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

% =========== packages ===========
\usepackage{préambule}
\usepackage[a4paper,top=2cm,bottom=1cm,left=1.5cm,right=1.5cm]{geometry} % Mise en page, marges
\usepackage{fancyhdr} % Haut et bas de page
\usepackage[shortlabels]{enumitem} % Pour facilement modifier les listes.

% =========== fancyhdr ===========
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
\let\definition\@undefined
\let\enddefinition\@undefined
\newmdenv[style=greenstyle]{definition}
\newmdenv[style=vocabulairestyle]{vocabulaire}

%Titre optionel pour les blocks 'Cours'
\makeatletter
\let\orig@cours=\cours
\def\cours{
  \@ifnextchar[{\cours@opt}{\orig@cours}
}
\def\cours@opt[#1]{
  \orig@cours[frametitle={Cours : #1}]
}
\makeatother

%Titre optionel pour les blocks 'Propriété'
\makeatletter
\let\orig@propriete=\propriete
\def\propriete{
  \@ifnextchar[{\propriete@opt}{\orig@propriete}
}
\def\propriete@opt[#1]{
  \orig@propriete[frametitle={Propriété : #1}]
}
\makeatother

%Titre optionel pour les blocks 'Définition'
\makeatletter
\let\orig@definition=\definition
\def\definition{
  \@ifnextchar[{\definition@opt}{\orig@definition}
}
\def\definition@opt[#1]{
  \orig@definition[frametitle={Définition : #1}]
}
\makeatother

% Titre optionel pour les blocks 'Méthode'
\makeatletter
\let\orig@methode=\methode
\def\methode{
  \@ifnextchar[{\methode@opt}{\orig@methode}
}
\def\methode@opt[#1]{
  \orig@methode[frametitle={Méthode : #1}]
}
\makeatother

% Titre optionel pour les blocks 'Application'
\makeatletter
\let\orig@application=\application
\def\application{
  \@ifnextchar[{\application@opt}{\orig@application}
}
\def\application@opt[#1]{
  \orig@application[frametitle={Application : #1}]
}
\makeatother

% Titre optionel pour les blocks 'Vocabulaire'
\makeatletter
\let\orig@vocabulaire=\vocabulaire
\def\vocabulaire{
  \@ifnextchar[{\vocabulaire@opt}{\orig@vocabulaire}
}
\def\vocabulaire@opt[#1]{
  \orig@vocabulaire[frametitle={Vocabulaire : #1}]
}
\makeatother

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