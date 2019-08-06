#
# Makefile -- build images for chapter 9
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	phi1.pdf phi2.pdf phi3.pdf Bphi1.pdf
	
phi1.pdf:	phi1.tex
	pdflatex phi1.tex

phi2.pdf:	phi2.tex
	pdflatex phi2.tex

phi3.pdf:	phi3.tex
	pdflatex phi3.tex

Bphi1.pdf:	Bphi1.tex
	pdflatex Bphi1.tex

B:	B.c
	gcc -o B -Wall -O2 B.c
