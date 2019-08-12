#
# Makefile zum Skript ueber Wavelets
#
# (c) 2019 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
all:	buch.pdf

#SUBDIRECTORIES = chapters uebungsaufgaben 
SUBDIRECTORIES = chapters papers/wwt

.PHONY:	images

images:
	for d in $(SUBDIRECTORIES); 					\
	do 								\
		(cd $${d}; make images); 				\
	done

include chapters/Makefile.inc
include papers/Makefile.inc

BUCHFILES =								\
	common/macros.tex						\
	common/lststyles.tex						\
	common/packages.tex						\
	titlepage.tex							\
	teilnehmer.tex							\
	$(CHAPTERS) 							\
	chapters/references.bib 					\
	$(PAPERFILES)

THEMA_FILES = 

TEXFILES = $(BUCHFILES) $(THEMA_FILES)

BLXFILES = \
	buch.bbl \
	buch1-blx.bbl \
 	buch2-blx.bbl \
	buch3-blx.bbl \
	buch4-blx.bbl \
	buch5-blx.bbl \
	buch6-blx.bbl \
	buch7-blx.bbl \
	buch8-blx.bbl \
	buch9-blx.bbl \
	buch10-blx.bbl \
	buch11-blx.bbl \
	buch12-blx.bbl \

buch.pdf:	buch.tex $(TEXFILES) buch.ind $(BLXFILES)
	pdflatex buch.tex
	bibtex buch

buch.idx:	buch.tex $(TEXFILES) images
	touch buch.ind
	pdflatex buch.tex

buch.ind:	buch.idx
	makeindex buch.idx

# References

buch.bbl:		buch.aux
	bibtex buch

buch1-blx.bbl:	buch1-blx.aux
	bibtex buch1-blx

buch2-blx.bbl:	buch2-blx.aux
	bibtex buch2-blx

buch3-blx.bbl:	buch3-blx.aux
	bibtex buch3-blx

buch4-blx.bbl:	buch4-blx.aux
	bibtex buch4-blx

buch5-blx.bbl:	buch5-blx.aux
	bibtex buch5-blx

buch6-blx.bbl:	buch6-blx.aux
	bibtex buch6-blx

buch7-blx.bbl:	buch7-blx.aux
	bibtex buch7-blx

buch8-blx.bbl:	buch8-blx.aux
	bibtex buch8-blx

buch9-blx.bbl:	buch9-blx.aux
	bibtex buch9-blx

buch10-blx.bbl:	buch10-blx.aux
	bibtex buch10-blx

buch11-blx.bbl:	buch11-blx.aux
	bibtex buch11-blx

buch12-blx.bbl:	buch12-blx.aux
	bibtex buch12-blx

clean:	cleansubdir
	rm -f *.bbl *.aux *.log *.out *.run.xml *.pdf *.blg *.idx *.ind \
		*.ilg *.toc *.synctex.gz *.auxlock *.bak *-blx.bib *.dvi

cleansubdir:
	for d in $(SUBDIRECTORIES); \
	do \
		cd $${d}; make clean; cd ..; \
	done

farbseiten.csv:	farbseiten.txt
	awk '{ printf("%d,", $$1) } END {printf("\n")}' farbseiten.txt > farbseiten.csv
