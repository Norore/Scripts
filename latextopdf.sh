#!/bin/bash

##---------------------------------------##
## Convertisseur automatique de fichier  ##
## LaTex en fichier pdf avec génération  ##
##  d'une bibliographie. Script-Shell    ##
##  créé par Nolwenn Lavielle. Dernière  ##
##  révision le Lundi 08 Février 2010.   ##
##---------------------------------------##

## si on a 2 arguments, alors on compile le premier fichier et on le renomme par le second argument ##

if [ $# -eq 2 ]
then
    ## on vérifie que le premier argument correspond bien à un document tex existant ##
    if [ -e "$1.tex" ]
    then
	pdflatex "$1.tex"
	bibtex "$1"
	pdflatex "$1.tex"
	pdflatex "$1.tex"
	echo ">> $1.tex compilé en $1.pdf <<"
	mv "$1.pdf" "$2.pdf"
	echo ">> $1.pdf renommé en $2.pdf <<"
	rm -f *.aux *.toc *.log *.dvi *.bbl *.blg *.lof *.lot *.aux
	echo "Suppression des fichiers intermédiaires issus de la compilation."
    else
	echo "/!\\ $1 n'est pas un fichier tex, compilation en pdf et renommage du fichier impossible. Attention à ne pas mettre l'extension du fichier pour la bonne procédure de la compilation./!\\"
    fi
fi

## si on a 1 argument, alors on le compile en fichier pdf ##
if [ $# -eq 1 ]
then
    if [ -e "$1.tex" ]
    then
	pdflatex "$1.tex"
	bibtex "$1"
	pdflatex "$1.tex"
	pdflatex "$1.tex"
	echo ">> $1.tex compilé en $1.pdf <<"
	rm -f *.aux *.toc *.log *.dvi *.bbl *.blg *.lof *.lot *.aux
	echo "Suppression des fichiers intermédiaires issus de la compilation."
    else
	echo "/!\\ $1 n'est pas un fichier tex, compilation en pdf et renommage du fichier impossible. Attention à ne pas mettre l'extension du fichier pour la bonne procédure de la compilation. /!\\"
    fi
fi

## si on n'a aucun ou plus de 2 arguments, on renvoit un message d'erreur avec explications ##

if [ $# -eq 0 ] || [ $# -gt 2 ]
then
    echo "Erreur dans le nombre d'arguments :"
    echo "vous devez entrer entre 1 et 2 arguments afin que la compilation s'effectue."
    echo "Si vous entrez un seul argument, le fichier sera compilé en format pdf et portera le même nom."
    echo "Si vous entrez deux arguments, le premier fichier sera compilé en format pdf et portera le nom du second argument."
    echo "/!\\ Le nom du fichier entré ne doit pas porter l'extension '.tex' pour la bonne procédure de la compilation. L'extension est ajoutée automatiquement par le script. /!\\"
fi
