#
# Makefile -- Bilder für die stetige Wavelet-Transformation
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	psigraph.pdf psisin.pdf

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
