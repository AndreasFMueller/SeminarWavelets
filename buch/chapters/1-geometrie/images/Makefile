#
# Makeifle -- build images for chapter 1
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	sinsin.pdf	\
	sincos.pdf	\
	sinrect.pdf	\
	cosrect.pdf	\
	sinrand.pdf	\
	translation.pdf	\
	dilatation.pdf	\
	kommutator.pdf	\
	kommutatorD.pdf	\
	hexagon.pdf	\
	hexagon1.pdf	\
	hexagon2.pdf	\
	hexagon3.pdf	\
	tri.pdf		\
	beispiel2.pdf	\
	b3-01.pdf	\
	b3-02.pdf	\
	b3-03.pdf	\
	b3-04.pdf	\
	b3-05.pdf	\
	b3-06.pdf	\
	b3-07.pdf	\
	b3-08.pdf	\
	b3-09.pdf	\
	b3-10.pdf

sinsin.pdf:	sinsin.tex sinpoints.tex
	pdflatex sinsin.tex

sincos.pdf:	sincos.tex cospoints.tex
	pdflatex sincos.tex

sinrect.pdf:	sinrect.tex rectpoints.tex
	pdflatex sinrect.tex

cosrect.pdf:	cosrect.tex rcospoints.tex
	pdflatex cosrect.tex

sinrand.pdf:	sinrand.tex randpoints.tex
	pdflatex sinrand.tex

pointfiles = 		\
	sinpoints.tex	\
	cospoints.tex	\
	randpoints.tex	\
	rectpoints.tex	\
	rcospoints.tex

$(pointfiles):	points.m
	octave points.m

translation.pdf:	translation.tex
	pdflatex translation.tex

dilatation.pdf:	dilatation.tex
	pdflatex dilatation.tex

kommutator.pdf:	kommutator.tex
	pdflatex kommutator.tex

kommutatorD.pdf:	kommutatorD.tex
	pdflatex kommutatorD.tex

hexagon.pdf:	hexagon.tex
	pdflatex hexagon.tex

hexagon1.pdf:	hexagon1.tex
	pdflatex hexagon1.tex

hexagon2.pdf:	hexagon2.tex
	pdflatex hexagon2.tex

hexagon3.pdf:	hexagon3.tex
	pdflatex hexagon3.tex

tri.png:	tri.pov
	povray +A0.1 -W1920 -H1080 -Otri.png tri.pov

tri.jpg:	tri.png Makefile
	convert -extract 960x1080+470+0 tri.png -density 300 -units PixelsPerInch tri.jpg

tri.pdf:	tri.tex tri.jpg
	pdflatex tri.tex

beispiel2.pdf:	beispiel2.tex
	pdflatex beispiel2.tex

b3curves.tex:	beispiel3.m
	octave beispiel3.m

b3-01.pdf:	b3-01.tex b3curves.tex axes.tex
	pdflatex b3-01.tex

b3-02.pdf:	b3-02.tex b3curves.tex axes.tex
	pdflatex b3-02.tex

b3-03.pdf:	b3-03.tex b3curves.tex axes.tex
	pdflatex b3-03.tex

b3-04.pdf:	b3-04.tex b3curves.tex axes.tex
	pdflatex b3-04.tex

b3-05.pdf:	b3-05.tex b3curves.tex axes.tex
	pdflatex b3-05.tex

b3-06.pdf:	b3-06.tex b3curves.tex axes.tex
	pdflatex b3-06.tex

b3-07.pdf:	b3-07.tex b3curves.tex axes.tex
	pdflatex b3-07.tex

b3-08.pdf:	b3-08.tex b3curves.tex axes.tex
	pdflatex b3-08.tex

b3-09.pdf:	b3-09.tex b3curves.tex axes.tex
	pdflatex b3-09.tex

b3-10.pdf:	b3-10.tex b3curves.tex axes.tex
	pdflatex b3-10.tex

