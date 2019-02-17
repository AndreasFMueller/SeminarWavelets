#
# Makefile -- intro
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	intro-handout.pdf MathSem-01-intro.pdf

SOURCES = common.tex slides.tex

MathSem-01-intro.pdf:	MathSem-01-intro.tex $(SOURCES)
	pdflatex MathSem-01-intro.tex

intro-handout.pdf:	intro-handout.tex $(SOURCES)
	pdflatex intro-handout.tex

