#
# Makefile -- Bilder für die stetige Wavelet-Transformation
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
single:	f.pdf

all:	psigraph.pdf psisin.pdf notes.pdf

psigraph.pdf:	psigraph.tex
	pdflatex psigraph.tex

psisin.pdf:	psisin.tex psidots.tex
	pdflatex psisin.tex
psidots.tex:	psi.m
	octave < psi.m

wsin.pdf:	wsin.tex wsindots.tex
	pdflatex wsin.tex

wsindots.tex:	wsin.m
	octave < wsin.m

notes.pdf:	notes.tex notes.png
	pdflatex notes.tex
notesdots.tex:	notes.m
	octave notes.m

notes:	notes.c
	gcc -o notes -Wall notes.c -lgsl -L/usr/local/lib -lpng16 -lz
notes.png:	notes
	./notes

f.pdf:	f.tex
	pdflatex f.tex
