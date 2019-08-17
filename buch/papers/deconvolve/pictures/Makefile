#
# Makefile -- edit images
#
all:	pix_ges-scaled.png psf.pdf function.pdf 1d.pdf y1_cwt.pdf result_1d.pdf dreieck.pdf cwt.pdf

pix_ges-scaled.png: pix_ges.png
	convert pix_ges.png -scale 1600% \
		-density 300 -units PixelsPerInch pix_ges-scaled.png

psf.pdf:	psf.tex
	pdflatex psf.tex

function.pdf:	function.tex
	pdflatex function.tex

1d.pdf:	1d.tex
	pdflatex 1d.tex

y1_cwt.pdf:	y1_cwt.tex
	pdflatex y1_cwt.tex

result_1d.pdf:	result_1d.tex
	pdflatex result_1d.tex

dreieck.pdf:	dreieck.tex
	pdflatex dreieck.tex

cwt.pdf:	cwt.tex
	pdflatex cwt.tex


