#
# Makefile -- umkehrformel
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	umkehrformel-handout.pdf MathSem-03-umkehrformel.pdf

SOURCES = common.tex slides.tex cwt.tex umkehrformel.tex

MathSem-03-umkehrformel.pdf:	MathSem-03-umkehrformel.tex $(SOURCES)
	pdflatex MathSem-03-umkehrformel.tex

umkehrformel-handout.pdf:	umkehrformel-handout.tex $(SOURCES)
	pdflatex umkehrformel-handout.tex

