#
# Makefile -- make images for MSA chapter
#
# (c) 2019 Prof Dr Andreas Müller
#
all:	msa.pdf hmpsidb3.pdf b2skal.pdf

msa.pdf:	msa.tex
	pdflatex msa.tex

hmpsidb3.pdf:	hmpsidb3.tex hmpsipath.tex
	pdflatex hmpsidb3.tex

hmpsipath.tex:	hmpsidb3.m
	octave hmpsidb3.m

b2skal.pdf:	b2skal.tex
	pdflatex b2skal.tex

