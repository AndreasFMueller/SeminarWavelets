#
# Makefile -- msa
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	msa-handout.pdf MathSem-04-msa.pdf

SOURCES = common.tex slides.tex						\
	haar.tex							\
	spaces.tex							\
	msa.tex								\
	schnell.tex							\
	sampling.tex							\
	average.tex							\
	phianalysis.tex							\
	aufloesung.tex

MathSem-04-msa.pdf:	MathSem-04-msa.tex $(SOURCES)
	pdflatex MathSem-04-msa.tex

msa-handout.pdf:	msa-handout.tex $(SOURCES)
	pdflatex msa-handout.tex

