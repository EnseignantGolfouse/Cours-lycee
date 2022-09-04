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
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
% \ProcessOptions\relax
\LoadClass[a4paper]{article}

\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page

%%fancyhdr
\AtBeginDocument{%
\setlength{\headheight}{15pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{Lycée La Martinière Diderot}
\makeatletter
\let\runtitle\@title
\fancyhead[C]{Mathématiques - \Options@classe}
\fancyhead[R]{\runtitle}
\makeatother
\fancypagestyle{plain}{ %
  \fancyhf{} % remove everything
  \renewcommand{\headrulewidth}{0pt} % remove lines as well
  \renewcommand{\footrulewidth}{0pt}
}
}

\makeatletter
\let\internal@maketitle=\maketitle
\def\maketitle{
  \internal@maketitle\thispagestyle{fancy}
}
\makeatother