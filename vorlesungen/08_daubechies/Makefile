#
# Makefile -- daubechies
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	daubechies-handout.pdf MathSem-08-daubechies.pdf

SOURCES = common.tex slides.tex

MathSem-08-daubechies.pdf:	MathSem-08-daubechies.tex $(SOURCES)
	pdflatex MathSem-08-daubechies.tex

daubechies-handout.pdf:	daubechies-handout.tex $(SOURCES)
	pdflatex daubechies-handout.tex

