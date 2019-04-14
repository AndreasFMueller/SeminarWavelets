#
# Makefile -- frames
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	frames-handout.pdf MathSem-09-frames.pdf

SOURCES = common.tex slides.tex comparison.tex voraussetzungen.tex \
	berechnung.tex domain.tex frame.tex straff.tex

MathSem-09-frames.pdf:	MathSem-09-frames.tex $(SOURCES)
	pdflatex MathSem-09-frames.tex

frames-handout.pdf:	frames-handout.tex $(SOURCES)
	pdflatex frames-handout.tex

