#
# Makefile -- intro
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	intro-handout.pdf MathSem-01-intro.pdf \
	gabor0.pdf				\
	gabor2.pdf				\
	gabor14.pdf				\
	gabor07.pdf				\
	gabor05.pdf				\
	gabor035.pdf				\
	gabor025.pdf				\
	welle.pdf

SOURCES = common.tex slides.tex

MathSem-01-intro.pdf:	MathSem-01-intro.tex $(SOURCES)
	pdflatex MathSem-01-intro.tex

intro-handout.pdf:	intro-handout.tex $(SOURCES)
	pdflatex intro-handout.tex

gabor0.pdf:	gabor0.tex wavelet.tex
	pdflatex gabor0.tex

gabor2.pdf:	gabor2.tex wavelet.tex
	pdflatex gabor2.tex

gabor05.pdf:	gabor05.tex wavelet.tex
	pdflatex gabor05.tex

gabor07.pdf:	gabor07.tex wavelet.tex
	pdflatex gabor07.tex

gabor035.pdf:	gabor035.tex wavelet.tex
	pdflatex gabor035.tex

gabor025.pdf:	gabor025.tex wavelet.tex
	pdflatex gabor025.tex

gabor14.pdf:	gabor14.tex wavelet.tex
	pdflatex gabor14.tex

welle.pdf:	welle.tex
	pdflatex welle.tex
