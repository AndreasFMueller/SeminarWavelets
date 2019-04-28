#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	haar.pdf gabor.pdf morlet.pdf

images:	haar.pdf gabor.pdf morlet.pdf

haar.pdf:	haar.tex haar.data
	pdflatex haar.tex

haar.data:	haar.m
	octave haar.m

gabor.pdf:	gabor.tex gabor.m
	pdflatex gabor.tex

gabor.data:	gabor.m
	octave gabor.m

morlet.pdf:	morlet.tex morlet.m
	pdflatex morlet.tex

morlet.data:	morlet.m
	octave morlet.m

