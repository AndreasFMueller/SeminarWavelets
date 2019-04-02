#
# Makefile -- fourier
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	fourier-handout.pdf MathSem-07-fourier.pdf

SOURCES =								\
	common.tex							\
	slides.tex							\
	plan.tex							\
	periodisierung.tex						\
	tphi.tex							\
	phipsi.tex							\
	H.tex								\
	V1.tex								\
	phi.tex

MathSem-07-fourier.pdf:	MathSem-07-fourier.tex $(SOURCES)
	pdflatex MathSem-07-fourier.tex

fourier-handout.pdf:	fourier-handout.tex $(SOURCES)
	pdflatex fourier-handout.tex

