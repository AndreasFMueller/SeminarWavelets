#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	haar.pdf

images:	haar.pdf

haar.pdf:	haar.tex haar.data
	pdflatex haar.tex

haar.data:	haar.m
	octave haar.m
