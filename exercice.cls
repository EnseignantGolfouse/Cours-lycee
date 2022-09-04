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
\DeclareBoolOption[false]{twocolumn}
\DeclareStringOption[Exercices]{exercices}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass[a4paper]{article}

% \usepackage{ifthenelse}
\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page

%%fancyhdr
\pagestyle{fancy}
\fancyhf{}
\makeatletter
\ifOptions@twocolumn
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
\makeatother
\fancypagestyle{plain}{%
  \fancyhf{} % remove everything
}

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