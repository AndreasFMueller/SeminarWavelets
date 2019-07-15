#
# Makefile -- skalorth
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	skalorth-handout.pdf MathSem-05-skalorth.pdf

SOURCES = common.tex slides.tex

MathSem-05-skalorth.pdf:	MathSem-05-skalorth.tex $(SOURCES)
	pdflatex MathSem-05-skalorth.tex

skalorth-handout.pdf:	skalorth-handout.tex $(SOURCES)
	pdflatex skalorth-handout.tex

