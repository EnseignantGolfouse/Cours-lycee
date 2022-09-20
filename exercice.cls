%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercice}[2022/09/04 Classe pour les exercices de mathématiques]

\usepackage{kvoptions}
\usepackage{kvoptions-patch}
\usepackage{ifthen}

%%This parts handles the options passed to the class.
\SetupKeyvalOptions{
	family=Options,
	prefix=Options@
}
\DeclareStringOption[]{classe}
\DeclareVoidOption{twocolumn}{
\makeatletter\newcommand{\internal@hastwocolumn}{}\makeatother%
}
\DeclareVoidOption{noheader}{\makeatletter\newcommand{\internal@noheader}{}\makeatother}
\DeclareStringOption[Exercices]{exercices}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass[a4paper]{article}

% =========== Packages ===========
\usepackage{préambule}
\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page

% =========== fancyhdr ===========
\makeatletter
\ifdefined\internal@noheader
\else
\pagestyle{fancy}
\fancyhf{}
\ifdefined\internal@hastwocolumn
\setlength{\headheight}{20pt}
\renewcommand{\headrule}{\hrulefill\hspace{20pt}\hrulefill}
\fancyhead[L,R]{\makebox[\columnwidth]{
	Lycée La Martinière Diderot
	\hfill
	\ifthenelse{\equal{\Options@classe}{}}{
		Mathématiques
	}{
		\Options@classe - Mathématiques
	}
	\hfill
	\Options@exercices
}}
\else
\setlength{\headheight}{15.5pt}
\fancyhead[L]{Lycée La Martinière Diderot}
\fancyhead[C]{
	\ifthenelse{\equal{\Options@classe}{}}{
		Mathématiques
	}{
		\Options@classe\space - Mathématiques
	}
}
\fancyhead[R]{\Options@exercices}
\fi
\fancypagestyle{plain}{%
  \fancyhf{} % remove everything
}
\fi
\makeatother

% =========== Autres définitions ===========
\makeatletter
\renewcommand{\maketitle}{
	\begin{center}
		\LARGE
		\uline{\@title}
		\vspace{1em}
	\end{center}
	\thispagestyle{fancy}
}
\makeatother