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
\DeclareVoidOption{noheader}{\makeatletter\newcommand{\internal@noheader}{}\makeatother}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
% \ProcessOptions\relax
\LoadClass[a4paper]{article}

% =========== packages ===========
\usepackage{préambule}
\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page
\usepackage[shortlabels]{enumitem} % Pour facilement modifier les listes.

% =========== fancyhdr ===========
\makeatletter
\ifdefined\internal@noheader
\else
\AtBeginDocument{%
\setlength{\headheight}{15.3pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{Lycée La Martinière Diderot}
\let\runtitle\@title
\ifthenelse{\equal{\Options@classe}{}}{
	\fancyhead[C]{Mathématiques}}{
	\fancyhead[C]{Mathématiques - \Options@classe}}
\fancyhead[R]{\runtitle}
\fancypagestyle{plain}{ %
  \fancyhf{} % remove everything
  \renewcommand{\headrulewidth}{0pt} % remove lines as well
  \renewcommand{\footrulewidth}{0pt}
}
}
\fi
\makeatother

% =========== Autres définitions ===========
\mdfdefinestyle{coursstyle}{
    style=redstyle,
    frametitle={Cours},
}
\mdfdefinestyle{proprietestyle}{
    style=redstyle,
    frametitle={Propriété},
}
\mdfdefinestyle{methodestyle}{
	style=redstyle,
    frametitle={Méthode},
}
\mdfdefinestyle{vocabulairestyle}{
	style=greenstyle,
    frametitle={Vocabulaire},
}
\mdfdefinestyle{exemplestyle}{
    style=bluestyle,
    frametitle={Exemple},
}
\mdfdefinestyle{remarquestyle}{
    style=bluestyle,
    frametitle={Remarque},
}

\newmdenv[style=exemplestyle]{exemple}
\newmdenv[style=remarquestyle]{remarque}
\newmdenv[style=applicationstyle]{application}
\newmdenv[style=coursstyle]{cours}
\newmdenv[style=proprietestyle]{propriete}
\newmdenv[style=methodestyle]{methode}
% \let\definition\@undefined
% \let\enddefinition\@undefined
\newmdenv[style=greenstyle]{definition}
\newmdenv[style=vocabulairestyle]{vocabulaire}

%=== Titres optionels
\directlua{
require "titresOptionels"

titreOptionel("cours", "Cours")
titreOptionel("propriete", "Propriété")
titreOptionel("methode", "Méthode")
titreOptionel("application", "Application")
titreOptionel("vocabulaire", "Vocabulaire")
titreOptionel("definition", "Définition")
}

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