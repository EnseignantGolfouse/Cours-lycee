#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
import os
import sys
import getopt
import shutil
from concurrent.futures import ThreadPoolExecutor
from typing import Any, Callable, NoReturn, Tuple
from colorama import Fore


DEFAULT_ARTIFACTS_DIR: str = ".build"
DEFAULT_EXCLUDE_PATHS: list[str] = ["./git submodules", "./.git"]


class Compilation:
    path: str
    input_extension: str
    output_extension: str
    output_dir: str
    artifacts_dir: str
    ignored_paths: list[str]
    compilation_function: Callable[[
        str, str, str, str], Tuple[str, Any | None]]

    def __init__(self, input_extension: str, output_extension: str) -> None:
        self.input_extension = input_extension
        self.output_extension = output_extension


def tex_compilation(path: str, artifacts_dir: str, ignored_paths: list[str]) -> Compilation:
    this = Compilation("tex", "pdf")
    this.output_dir = "pdf"
    this.path = path
    this.ignored_paths = ignored_paths
    this.artifacts_dir = artifacts_dir
    this.compilation_function = compile_tex_file
    return this


def asciidoctor_compilation(path: str, artifacts_dir: str, ignored_paths: list[str]) -> Compilation:
    this = Compilation("adoc", "html")
    this.output_dir = "html"
    this.path = path
    this.ignored_paths = ignored_paths
    this.artifacts_dir = artifacts_dir
    this.compilation_function = compile_adoc_file
    return this


def typst_compilation(path: str, artifacts_dir: str, ignored_paths: list[str]) -> Compilation:
    this = Compilation("typ", "pdf")
    this.output_dir = "pdf"
    this.path = path
    this.ignored_paths = ignored_paths
    this.artifacts_dir = artifacts_dir
    this.compilation_function = compile_typst_file
    return this


def find_files_in(compilation: Compilation) -> list[Tuple[str, str, str]]:
    extension = "." + compilation.input_extension
    normalized_ignored_paths: list[str] = []
    for path in DEFAULT_EXCLUDE_PATHS:
        normalized_ignored_paths.append(os.path.normpath(path))
    for path in compilation.ignored_paths:
        normalized_ignored_paths.append(os.path.normpath(path))
    return find_files_recursive(compilation.path, extension, normalized_ignored_paths)


def find_files_recursive(directory: str, extension: str, ignored_paths: list[str]) -> list[Tuple[str, str, str]]:
    """
    Recursively find all files in `directory` with extension `extension`.
    Returns a list of `(dir, file)`, where
    - `dir` is the directory where the file was found
    - `file` is the base name of the file.

    Note that git submodules are excluded.
    """
    result: list[Tuple[str, str, str]] = []

    if os.path.normpath(directory) in ignored_paths:
        return result
    for item in os.listdir(directory):
        name: str = os.path.join(directory, item)
        if os.path.isfile(name):
            if name.endswith(extension):
                result.append((directory, item, name[:-len(extension)]))
        elif os.path.isdir(name):
            result.extend(find_files_recursive(
                name, extension, ignored_paths))
    return result


def compile_tex_file(working_dir: str, build_dir: str, output_dir: str, input_file: str) -> Tuple[str, Any | None]:
    """
    Returns `None` if no error happened.
    Else, returns the error message.
    # Parameters
    - `working_dir` is the absolute directory in which subprocesses will be executed.
    - `build_dir` is the absolute directory in which to place intermediary build artifacts.
    - `output_dir` is a directory, relative to `working_dir`, in which to place the resulting pdf.
    - `input_file` is the path of the input file, relative to `working_dir`.   """
    returned_file_tex: str = os.path.join(working_dir, input_file)
    working_dir = os.path.abspath(working_dir)
    output_file: str = input_file[:-4] + ".pdf"
    error: Any | None = None
    try:
        subprocess.check_output(
            args=[
                "latexmk",
                "-lualatex",
                "-output-directory=" + build_dir,
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                input_file
            ],
            stderr=subprocess.STDOUT,
            cwd=working_dir)
        os.makedirs(os.path.join(working_dir, output_dir), exist_ok=True)
        shutil.copyfile(os.path.join(build_dir, output_file),
                        os.path.join(working_dir, output_dir, output_file))
    except subprocess.CalledProcessError as process_error:
        error = process_error.output.decode("utf-8")
    except Exception as e:
        raise e
    finally:
        if error != None:
            return (returned_file_tex, error)
        else:
            return (returned_file_tex, None)


def compile_adoc_file(working_dir: str, build_dir: str, output_dir: str, input_file: str) -> Tuple[str, Any | None]:
    """
    Returns `None` if no error happened.
    Else, returns the error message.
    # Parameters
    - `working_dir` is the absolute directory in which subprocesses will be executed.
    - `build_dir` is the absolute directory in which to place intermediary build artifacts.
    - `output_dir` is a directory, relative to `working_dir`, in which to place the resulting pdf.
    - `input_file` is the path of the input file, relative to `working_dir`.   """
    returned_file_adoc: str = os.path.join(working_dir, input_file)
    working_dir = os.path.abspath(working_dir)
    output_file: str = input_file[:-4] + "html"
    error: Any | None = None
    try:
        subprocess.check_output(
            args=[
                "asciidoctor",
                "--out-file",
                os.path.join(build_dir, output_file),
                input_file
            ],
            stderr=subprocess.STDOUT,
            cwd=working_dir)
        os.makedirs(os.path.join(working_dir, output_dir), exist_ok=True)
        shutil.copyfile(os.path.join(build_dir, output_file),
                        os.path.join(working_dir, output_dir, output_file))
    except subprocess.CalledProcessError as process_error:
        error = process_error.output.decode("utf-8")
    except Exception as e:
        raise e
    finally:
        if error != None:
            return (returned_file_adoc, error)
        else:
            return (returned_file_adoc, None)


def compile_typst_file(working_dir: str, build_dir: str, output_dir: str, input_file: str) -> Tuple[str, Any | None]:
    """
    Returns `None` if no error happened.
    Else, returns the error message.
    # Parameters
    - `working_dir` is the absolute directory in which subprocesses will be executed.
    - `build_dir` is the absolute directory in which to place intermediary build artifacts.
    - `output_dir` is a directory, relative to `working_dir`, in which to place the resulting pdf.
    - `input_file` is the path of the input file, relative to `working_dir`.   """
    returned_file_typst: str = os.path.join(working_dir, input_file)
    working_dir = os.path.abspath(working_dir)
    output_file_TEMP: str = input_file[:-3] + "TEMP" + "pdf"
    output_file: str = input_file[:-3] + "pdf"
    error: Any | None = None
    try:
        os.makedirs(build_dir, exist_ok=True)
        subprocess.check_output(
            args=[
                "typst",
                "compile",
                input_file,
                os.path.join(build_dir, output_file_TEMP),
            ],
            stderr=subprocess.STDOUT,
            cwd=working_dir)
        os.makedirs(os.path.join(working_dir, output_dir), exist_ok=True)
        # Repair the pdf
        subprocess.check_output(
            args=[
                "pdftocairo",
                "-pdf",
                os.path.join(build_dir, output_file_TEMP),
                os.path.join(build_dir, output_file),
            ],
            stderr=subprocess.STDOUT,
            cwd=working_dir)
        shutil.copyfile(os.path.join(build_dir, output_file),
                        os.path.join(working_dir, output_dir, output_file))
    except subprocess.CalledProcessError as process_error:
        error = process_error.output.decode("utf-8")
    except Exception as e:
        raise e
    finally:
        if error != None:
            return (returned_file_typst, error)
        else:
            return (returned_file_typst, None)


file_number: int = 1
total_ok: int = 0
total_err: int = 0


def compile_all(compilation: Compilation, jobs: int) -> None:
    """
    Find and compile all input files in the current directory (and all its subdirectories).

    - All compilation artifacts will be placed in `artifacts_dir` (relative to the current directory).
    - The resulting pdf will be placed in `output_dir` (relative to the input file).

    The compiling command is `latexmk -lualatex -output-directory=<artifacts_dir> -synctex=1 -interaction=nonstopmode -file-line-error`.
    """
    global file_number, total_ok, total_err

    build_dir: str = os.path.abspath(DEFAULT_ARTIFACTS_DIR)
    package_dir: str = os.path.abspath(os.path.join(build_dir, os.path.pardir))

    os.environ["TEXINPUTS"] = "::" + package_dir

    input_files: list[Tuple[str, str, str]] = find_files_in(
        compilation)
    total_files: int = len(input_files)
    failed_files: list = []
    file_number = 1
    total_ok = 0
    total_err = 0

    def executing_function(inputs: Tuple[str, str, str]):
        global file_number, total_ok, total_err
        (input_file, error) = compilation.compilation_function(
            inputs[0], inputs[1], compilation.output_dir, inputs[2])
        print(
            Fore.CYAN + f"{file_number}/{total_files} " + Fore.RESET
            + input_file,
            end="")
        file_number += 1
        if error == None:
            total_ok += 1
            print("  " + Fore.GREEN + "OK" + Fore.RESET)
        else:
            total_err += 1
            print("  " + Fore.RED + "[ERROR]" + Fore.RESET)
            print(error)
            failed_files.append(input_file)

    with ThreadPoolExecutor(max_workers=jobs) as executor:
        to_map: list[Tuple[str, str, str]] = []
        for (directory, input_file, file_hash) in input_files:
            file_build_dir: str = os.path.abspath(
                os.path.join(build_dir, str(file_hash)))
            to_map.append((directory,
                           file_build_dir,
                           input_file))

        executor.map(executing_function, to_map)

    print()
    print()
    print("    OK:", total_ok, ", ERR:", total_err)
    print()
    if total_err > 0:
        print(
            Fore.RED + f"Errors detected: {total_err} files failed to build" + Fore.RESET)
        print("The following files had errors:")
        for file in failed_files:
            print("  ", file)
    else:
        print(Fore.GREEN, "No error detected !" + Fore.RESET)


def clean(compile_files: Compilation):
    """
    Find all input files in `path` (and all its subdirectories), and remove orphan pdfs in `output_dir`.
    """
    tex_files_dict: dict[str, list[str]] = {}
    for (directory, tex_file, _) in find_files_in(compile_files):
        if tex_files_dict.get(directory) == None:
            tex_files_dict[directory] = [tex_file]
        else:
            tex_files_dict[directory].append(tex_file)

    total_removed: int = 0
    for directory in tex_files_dict:
        out_dir: str = os.path.join(directory, compile_files.output_dir)
        input_files: list[str] = tex_files_dict[directory]
        if not os.path.exists(out_dir):
            continue
        for output_file in os.listdir(out_dir):
            if not output_file.endswith("." + compile_files.output_extension):
                continue
            should_remove: bool = True
            for tex_file in input_files:
                if tex_file[:-4] == output_file[:-4]:
                    should_remove = False
                    break
            if not should_remove:
                continue
            try:
                file_to_remove: str = os.path.join(out_dir, output_file)
                os.remove(file_to_remove)
                print(file_to_remove, Fore.RED, "[REMOVED]", Fore.RESET)
                total_removed += 1
            except Exception as e:
                raise e
    print()
    print(f"Removed {total_removed} outdated files.")


def clean_all(compile_files: Compilation) -> None:
    """
    Remove all intermediate and final objects generated by this binary.

    - removes the `compile_files.artifacts_dir` (relative to the current directory).
    - removes the `compile_files.output_dir` (relative to the input files).
    """
    tex_files: list = find_files_in(compile_files)
    root_dir: str = os.path.abspath(".")
    build_dir: str = os.path.join(root_dir, compile_files.artifacts_dir)
    if os.path.exists(build_dir):
        print("removing ", build_dir)
        shutil.rmtree(build_dir, ignore_errors=True)
    for (directory, _, _) in tex_files:
        output_dir: str = os.path.join(directory, compile_files.output_dir)
        if os.path.exists(output_dir):
            print("removing ", output_dir)
            shutil.rmtree(output_dir, ignore_errors=True)


def adjust_lua_path() -> None:
    env_var_lua_path: str | None = os.getenv("LUA_PATH")
    if env_var_lua_path != None:
        new_path: str = os.path.abspath(".") + "/scripts_lua/?.lua"
        os.environ["LUA_PATH"] = new_path + ";" + env_var_lua_path


def check_executables() -> None:
    """
    Check that all used executables exist.
    """
    # executables run by the subprocess.check_output function
    used_cmd: list[str] = ["latexmk", "lualatex", "asciidoctor"]
    for cmd in used_cmd:
        if shutil.which(cmd) == None:
            print(
                Fore.RED, f"ERROR: command {cmd} does not exists, please install it.", Fore.RESET)
            exit(1)


def print_help(exit_code: int) -> NoReturn:
    print(
        """helper to build tex and asciidoctor files.

USAGE:
    build_all.py [OPTIONS]

By default, this will not build anything under "./git submodules" and "./.git".

OPTIONS:
    -h, --help             Prints help information
    -p, --path <PATH>      Only build tex files under PATH. This defaults to the current directory.
    -i, --ignore <PATH>    Ignore all files under the specified path. This option can be specified multiple times.
    -j, --jobs <INT>       The maximum numbers of parallel processes. Defaults to the number of processors of the machine.
        --clean <PATH>     Remove pdfs without an associated .tex file, and html files without an associated .adoc file.
        --clean-all <PATH> Clean all pdf and html files.
""")
    sys.exit(exit_code)


def main(script_args: list[str]) -> None:
    check_executables()
    adjust_lua_path()
    path: str = "."
    opts: list[Tuple[str, str]]
    try:
        opts, _ = getopt.getopt(
            script_args, "hp:i:j:", ["help", "path=", "ignore=", "jobs=", "clean", "clean-all"])
    except getopt.GetoptError:
        print(Fore.RED + "ERROR: invalid arguments" + Fore.RESET)
        print_help(2)
    cleaning_level: int = 0
    number_of_cpus: int | None = os.cpu_count()
    number_of_cpus = 1 if number_of_cpus == None else number_of_cpus
    ignored: list[str] = []
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print_help(0)
        elif opt in ("-p", "--path"):
            path = arg
        elif opt in ("-i", "--ignore"):
            ignored.append(arg)
        elif opt in ("-j", "--jobs"):
            number_of_cpus = int(arg)
        elif opt in ("--clean"):
            cleaning_level = 1
        elif opt in ("--clean-all"):
            cleaning_level = 2
    compile_tex_files: Compilation = tex_compilation(
        path, DEFAULT_ARTIFACTS_DIR, ignored)
    compile_adoc_files: Compilation = asciidoctor_compilation(
        path, DEFAULT_ARTIFACTS_DIR, ignored)
    compile_typst_files: Compilation = typst_compilation(
        path, DEFAULT_ARTIFACTS_DIR, ignored)
    if cleaning_level == 1:
        clean(compile_tex_files)
        clean(compile_adoc_files)
        clean(compile_typst_files)
    elif cleaning_level == 2:
        confirm: bool = False
        full_path: str = os.path.abspath(path)
        print(
            f"This will remove ALL pdf files in {full_path}: continue ? (Y/N)")
        user_input: str = input()
        if user_input == "Y" or user_input == "y":
            confirm = True
        if confirm:
            clean_all(compile_tex_files)
            clean_all(compile_adoc_files)
            clean_all(compile_typst_files)
        else:
            print("aborting clean.")
    else:
        compile_all(compile_adoc_files, number_of_cpus)
        compile_all(compile_tex_files, number_of_cpus)
        compile_all(compile_typst_files, number_of_cpus)


if __name__ == "__main__":
    main(sys.argv[1:])
