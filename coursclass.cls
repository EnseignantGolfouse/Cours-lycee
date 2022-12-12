%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coursclass}[2022/09/04 Classe pour le cours de mathématiques]

\usepackage{kvoptions}
\usepackage{kvoptions-patch}

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
\DeclareStringOption[Cours]{headerTitle}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
% \ProcessOptions\relax
\LoadClass[a4paper]{article}

\usepackage{préambule-cours}
\usepackage[shortlabels]{enumitem} % Pour facilement modifier les listes.
\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page

\makeatletter
\let\internal@maketitle=\maketitle
\def\maketitle{
  \internal@maketitle\thispagestyle{fancy}
}
\makeatother

\setlist[itemize,1]{label=•}
\setlist[itemize,2]{label=◦}
\setlist[itemize,3]{label=■}
\setlist[itemize,4]{label=□}

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
\fancypagestyle{plain}{%
  \fancyhf{} % remove everything
}
\fi
\makeatother