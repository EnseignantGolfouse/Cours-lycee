%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{évaluation}[2022/09/12 Classe pour les évaluations de mathématiques]

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
\DeclareStringOption[Évaluation]{headerTitle}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass[a4paper]{article}

% =========== Packages ===========
\usepackage{préambule}
\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page

% =========== fancyhdr ===========
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
	\Options@headerTitle
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
\fancyhead[R]{\Options@headerTitle}
\fi
\makeatother
\fancypagestyle{plain}{%
  \fancyhf{} % remove everything
}

% =========== Autres définitions ===========
\newcounter{exerciceCounter}
\setcounter{exerciceCounter}{1}
\renewenvironment{exercice}[1][]{
\vspace{0.5em}
\textbf{\uline{Exercice \theexerciceCounter}}
\ifthenelse{\equal{#1}{}}{}
{(#1 points)}%
:
}{%
\vspace{0.5em}%
\stepcounter{exerciceCounter}%
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

% L'argument optionel remplit le champ "prénom".
\makeatletter
\newcommand{\TitreDEvaluation}[2][]{%
\renewcommand{\maketitle}{%
	Prénom: \ifthenelse{\equal{#1}{}}{........................}{{#1}} \hfill \@date
	\begin{center}
		\LARGE
		#2
	\end{center}
	\vspace{1em}
}
}
\makeatother