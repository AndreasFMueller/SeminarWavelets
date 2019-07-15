#
# Makefile -- make images for MSA chapter
#
# (c) 2019 Prof Dr Andreas Müller
#
all:	msa.pdf hmpsidb3.pdf

msa.pdf:	msa.tex
	pdflatex msa.tex

hmpsidb3.pdf:	hmpsidb3.tex hmpsipath.tex
	pdflatex hmpsidb3.tex

hmpsipath.tex:	hmpsidb3.m
	octave hmpsidb3.m

