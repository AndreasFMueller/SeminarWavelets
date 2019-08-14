#
# Makefile -- Bilder für die stetige Wavelet-Transformation
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	psigraph.pdf psisin.pdf notes.pdf f.pdf mexican.pdf \
	sweep.pdf sweep2.pdf \
	hatpsi.pdf

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

mexican.pdf:	mexican.tex
	pdflatex mexican.tex

sweep:	sweep.cpp
	g++ -o sweep -Wall -O2 -g sweep.cpp -L/usr/local/lib -lpng16 -lz 

sweep.png:	sweep
	./sweep -M -osweep.png
sweep.jpg:	sweep.png
	convert sweep.png -density 300 -units PixelsPerInch sweep.jpg

sweep-abs.png:	sweep
	./sweep -M -A -osweep-abs.png
sweep-abs.jpg:	sweep-abs.png
	convert sweep-abs.png -density 300 -units PixelsPerInch sweep-abs.jpg

sweep-phase.png:	sweep
	./sweep -M -P -osweep-phase.png
sweep-phase.jpg:	sweep-phase.png
	convert sweep-phase.png -density 300 -units PixelsPerInch sweep-phase.jpg

sweep.pdf:	sweep.jpg sweep.tex
	pdflatex -interaction=batchmode sweep.tex

sweep2.pdf:	sweep-abs.jpg sweep-phase.jpg sweep2.tex
	pdflatex -interaction=batchmode sweep2.tex

hatpsi.pdf:	hatpsi.tex
	pdflatex hatpsi.tex
