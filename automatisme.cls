%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{automatisme}[2022/11/29 Classe pour les débuts de cours]

\usepackage{kvoptions}
\usepackage{kvoptions-patch}
\usepackage{ifthen}

%%This parts handles the options passed to the class.
\SetupKeyvalOptions{
	family=Options,
	prefix=Options@
}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessKeyvalOptions*
\LoadClass[a4paper]{beamer}

% =========== Packages ===========
\usepackage{préambule}


\setbeamertemplate{itemize item}{\bullet}