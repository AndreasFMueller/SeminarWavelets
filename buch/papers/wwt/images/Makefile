#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all: gabor.pdf center.pdf
clean:
	rm -rf *.aux *.data *.log gabor.pdf centerf.pdf

images: gabor.pdf centerf.pdf


gabor.pdf:	gabor.tex
	pdflatex gabor.tex

centerf.pdf:	centerf.tex
	pdflatex centerf.tex

