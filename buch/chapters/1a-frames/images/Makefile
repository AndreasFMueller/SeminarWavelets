#
# Makeifle -- build images for chapter 1
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	hexagon.pdf	\
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
	b3-10.pdf	\
	iteration.pdf	\
	itkonv.pdf	\
	ibkonv.pdf	\
	div.pdf

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

iteration.pdf:	iteration.tex
	pdflatex iteration.tex

itkonv.pdf:	itkonv.tex
	pdflatex itkonv.tex

ibkonv.pdf:	ibkonv.tex
	pdflatex ibkonv.tex

div.pdf:	div.tex
	pdflatex div.tex

