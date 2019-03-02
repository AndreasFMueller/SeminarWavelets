#
# Makefile -- cwt
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	cwt-handout.pdf MathSem-02-cwt.pdf

SOURCES = common.tex slides.tex				\
	plan.tex					\
	skalarprodukt.tex				\
	trafo.tex					\
	gabor.tex					\
	dilatation.tex					\
	translation.tex					\
	transdil.tex					\
	cwt.tex						\
	fourier.tex

MathSem-02-cwt.pdf:	MathSem-02-cwt.tex $(SOURCES)
	pdflatex MathSem-02-cwt.tex

cwt-handout.pdf:	cwt-handout.tex $(SOURCES)
	pdflatex cwt-handout.tex

