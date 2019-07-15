#
# Makefile -- fast
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	fast-handout.pdf MathSem-06-fast.pdf

SOURCES = common.tex slides.tex db.tex analyse.tex umkehrung.tex

MathSem-06-fast.pdf:	MathSem-06-fast.tex $(SOURCES)
	pdflatex MathSem-06-fast.tex

fast-handout.pdf:	fast-handout.tex $(SOURCES)
	pdflatex fast-handout.tex

