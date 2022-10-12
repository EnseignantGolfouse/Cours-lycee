#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
import os
import sys
import getopt
import shutil
from concurrent.futures import ThreadPoolExecutor
from colorama import Fore


DEFAULT_ARTIFACTS_DIR = ".build"
DEFAULT_OUTPUT_DIR = "pdf"
DEFAULT_EXCLUDE_PATHS = ["./git submodules", "./.git"]


def find_tex_files_in(directory: str, ignored_paths: list = []) -> list:
    normalized_ignored_paths = []
    for path in DEFAULT_EXCLUDE_PATHS:
        normalized_ignored_paths.append(os.path.normpath(path))
    for path in ignored_paths:
        normalized_ignored_paths.append(os.path.normpath(path))
    return find_tex_files_recursive(directory, normalized_ignored_paths)


def find_tex_files_recursive(directory: str, ignored_paths: list) -> list:
    """
    Recursively find all `.tex` files in `directory`.
    Returns a list of `(dir, file)`, where
    - `dir` is the directory where the file was found
    - `file` is the base name of the file.

    Note that git submodules are excluded.
    """
    result: list = []

    if os.path.normpath(directory) in ignored_paths:
        return result
    for item in os.listdir(directory):
        name: str = os.path.join(directory, item)
        if os.path.isfile(name):
            if name.endswith(".tex"):
                result.append((directory, item, name[:-4]))
        elif os.path.isdir(name):
            result.extend(find_tex_files_recursive(name, ignored_paths))
    return result


def compile_file(inputs: (str,  str,  str,  str)) -> (bool):
    """
    Returns `None` if no error happened.
    Else, returns the error message.
    # Parameters
    - `working_dir` is the absolute directory in which subprocesses will be executed.
    - `build_dir` is the absolute directory in which to place intermediary build artifacts.
    - `output_dir` is a directory, relative to `working_dir`, in which to place the resulting pdf.
    - `file_tex` is the path of the input .tex file, relative to `working_dir`.   """
    (working_dir, build_dir, output_dir, file_tex) = inputs
    returned_file_tex = os.path.join(working_dir, file_tex)
    working_dir = os.path.abspath(working_dir)
    file_pdf: str = file_tex[:-4] + ".pdf"
    error = None
    try:
        subprocess.check_output(
            args=[
                "latexmk",
                "-lualatex",
                "-output-directory=" + build_dir,
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                file_tex
            ],
            stderr=subprocess.STDOUT,
            cwd=working_dir)
        os.makedirs(os.path.join(working_dir, output_dir), exist_ok=True)
        shutil.copyfile(os.path.join(build_dir, file_pdf),
                        os.path.join(working_dir, output_dir, file_pdf))
    except subprocess.CalledProcessError as process_error:
        error = process_error.output.decode("utf-8")
    except Exception as e:
        raise e
    finally:
        if error != None:
            return (returned_file_tex, error)
        else:
            return (returned_file_tex, None)


file_number: int = 1
total_ok: int = 0
total_err: int = 0


def compile_all(path: str, artifacts_dir: str, pdf_dir: str, jobs: int, ignored_paths: list):
    """
    Find and compile all `.tex` files in the current directory (and all its subdirectories).

    - All compilation artifacts will be placed in `artifacts_dir` (relative to the current directory).
    - The resulting pdf will be placed in `output_dir` (relative to the `.tex` file).

    The compiling command is `latexmk -lualatex -output-directory=<artifacts_dir> -synctex=1 -interaction=nonstopmode -file-line-error`.
    """
    global file_number, total_ok, total_err

    build_dir: str = os.path.abspath(artifacts_dir)
    package_dir: str = os.path.abspath(os.path.join(build_dir, os.path.pardir))

    os.environ["TEXINPUTS"] = "::" + package_dir

    tex_files: list = find_tex_files_in(path, ignored_paths)
    total_files: int = len(tex_files)
    failed_files: list = []
    file_number = 1
    total_ok = 0
    total_err = 0

    def executing_function(inputs):
        global file_number, total_ok, total_err
        (file_tex, error) = compile_file(inputs)
        print(
            Fore.CYAN + f"{file_number}/{total_files} " + Fore.RESET
            + file_tex,
            end="")
        file_number += 1
        if error == None:
            total_ok += 1
            print("  " + Fore.GREEN + "OK" + Fore.RESET)
        else:
            total_err += 1
            print("  " + Fore.RED + "[ERROR]" + Fore.RESET)
            print(error)
            failed_files.append(file_tex)

    with ThreadPoolExecutor(max_workers=jobs) as executor:
        to_map = []
        for (directory, file_tex, file_hash) in tex_files:
            file_build_dir = os.path.abspath(
                os.path.join(build_dir, str(file_hash)))
            to_map.append((directory,
                           file_build_dir,
                           pdf_dir,
                           file_tex))

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


def clean(path: str, output_dir: str):
    """
    Find all '.tex' files in `path` (and all its subdirectories), and remove orphan pdfs in `output_dir`.
    """
    tex_files: list = find_tex_files_in(path)

    tex_files_dict = {}
    for (directory, tex_file, _) in tex_files:
        if tex_files_dict.get(directory) == None:
            tex_files_dict[directory] = [tex_file]
        else:
            tex_files_dict[directory].append(tex_file)

    total_removed: int = 0
    for directory in tex_files_dict:
        pdf_dir = os.path.join(directory, output_dir)
        tex_files = tex_files_dict[directory]
        if not os.path.exists(pdf_dir):
            continue
        for pdf_file in os.listdir(pdf_dir):
            if not pdf_file.endswith(".pdf"):
                continue
            should_remove = True
            for tex_file in tex_files:
                if tex_file[:-4] == pdf_file[:-4]:
                    should_remove = False
                    break
            if not should_remove:
                continue
            try:
                file_to_remove = os.path.join(pdf_dir, pdf_file)
                os.remove(file_to_remove)
                print(file_to_remove, Fore.RED, "[REMOVED]", Fore.RESET)
                total_removed += 1
            except Exception as e:
                raise e
    print()
    print(f"Removed {total_removed} outdated files.")


def clean_all(path: str, artifacts_dir: str, output_dir: str):
    """
    Remove all intermediate and final objects generated by this binary.

    - removes the `artifacts_dir` (relative to the current directory).
    - removes the `output_dir` (relative to the `.tex` file).
    """
    tex_files: list = find_tex_files_in(path)
    root_dir: str = os.path.abspath(".")
    build_dir: str = os.path.join(root_dir, artifacts_dir)
    if os.path.exists(build_dir):
        print("removing ", build_dir)
        shutil.rmtree(build_dir, ignore_errors=True)
    for (directory, file_tex, _) in tex_files:
        pdf_dir = os.path.join(directory, output_dir)
        if os.path.exists(pdf_dir):
            print("removing ", pdf_dir)
            shutil.rmtree(pdf_dir, ignore_errors=True)


def adjust_lua_path():
    env_var_lua_path = os.getenv("LUA_PATH")
    lua_path: str = ""
    if env_var_lua_path:
        lua_path = env_var_lua_path
    new_path: str = os.path.abspath(".") + "/scripts_lua/?.lua"
    os.environ["LUA_PATH"] = new_path + ";" + lua_path


def check_executables():
    """
    Check that all used executables exist.
    """
    # executables run by the subprocess.check_output function
    used_cmd = ["latexmk", "lualatex"]
    for cmd in used_cmd:
        if shutil.which(cmd) == None:
            print(
                Fore.RED, f"ERROR: command {cmd} does not exists, please install it.", Fore.RESET)
            exit(1)


def print_help(exit_code: int):
    print(
        """helper to build tex files.

USAGE:
    build_all_pdf.py [OPTIONS]

By default, this will not build anything under "./git submodules" and "./.git".

OPTIONS:
    -h, --help             Prints help information
    -p, --path <PATH>      Only build tex files under PATH. This defaults to the current directory.
    -i, --ignore <PATH>    Ignore all files under the specified path. This option can be specified multiple times.
    -j, --jobs <INT>       The maximum numbers of parallel processes. Defaults to the number of processors of the machine.
        --clean <PATH>     Remove pdf without associated .tex file.
        --clean-all <PATH> Clean all pdfs.
""")
    sys.exit(exit_code)


def main(args: list):
    check_executables()
    adjust_lua_path()
    path = "."
    try:
        opts, args = getopt.getopt(
            args, "hp:i:j:", ["help", "path=", "ignore=", "jobs=", "clean", "clean-all"])
    except getopt.GetoptError:
        print(Fore.RED + "ERROR: invalid arguments" + Fore.RESET)
        print_help(2)
    cleaning_level: int = 0
    number_of_cpus: int = os.cpu_count()
    ignored = []
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print_help(0)
        elif opt in ("-p", "--path"):
            path = arg
            DEFAULT_EXCLUDE_PATHS = []
        elif opt in ("-i", "--ignore"):
            ignored.append(arg)
        elif opt in ("-j", "--jobs"):
            number_of_cpus = int(arg)
        elif opt in ("--clean"):
            cleaning_level = 1
        elif opt in ("--clean-all"):
            cleaning_level = 2
    if cleaning_level == 1:
        clean(path, DEFAULT_OUTPUT_DIR)
    elif cleaning_level == 2:
        confirm = False
        full_path = os.path.abspath(path)
        print(f"This will remove ALL pdfs in {full_path}: continue ? (Y/N)")
        user_input = input()
        if user_input == "Y" or user_input == "y":
            confirm = True
        if confirm:
            clean_all(path, DEFAULT_ARTIFACTS_DIR, DEFAULT_OUTPUT_DIR)
        else:
            print("aborting clean.")
    else:
        compile_all(path, DEFAULT_ARTIFACTS_DIR,
                    DEFAULT_OUTPUT_DIR, number_of_cpus, ignored)


if __name__ == "__main__":
    main(sys.argv[1:])
