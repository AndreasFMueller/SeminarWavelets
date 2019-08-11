#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
# (c) 2019 Roy Seitz, Hochschule Rapperswil
#
.PHONY: all images clean
MAKEFLAGS+=" -j "

all:
images:	ahaar.pdf haar.pdf haar_dom.pdf gabor.pdf morlet.pdf \
	signals.pdf signal_padding.pdf \
	cyclic_conv.pdf \
	chirp_morlet.pdf square_morlet.pdf \
	chirp_haar.pdf square_haar.pdf \
	chirp_ahaar.pdf square_ahaar.pdf \
	chirp_gabor.pdf square_gabor.pdf \
	padding_none.pdf padding_zero.pdf \
	padding_sym.pdf padding_sym_conj.pdf 
# 	add_cs_chirp.pdf add_rs_square_haar.pdf \
# 	add_cs_haar_chirp.pdf \
# 	test.pdf

clean:
	rm -rf *.aux *.log *.synctex.gz *.dat *.png *.jpg

signals.pdf: signals.tex
	pdflatex -interaction=batchmode signals.tex && rm signals.log signals.aux

signal_padding.pdf: signal_padding.tex
	pdflatex -interaction=batchmode signal_padding.tex && rm signal_padding.log signal_padding.aux

cyclic_conv.pdf: cyclic_conv.tex
	pdflatex -interaction=batchmode cyclic_conv.tex && rm cyclic_conv.log cyclic_conv.aux

ahaar.pdf: ahaar.tex
	pdflatex -interaction=batchmode ahaar.tex && rm ahaar.log ahaar.aux

haar.pdf: haar.tex
	pdflatex -interaction=batchmode haar.tex && rm haar.log haar.aux

haar_dom.pdf: haar_dom.tex
	pdflatex -interaction=batchmode haar_dom.tex && rm haar_dom.log haar_dom.aux

gabor.pdf: gabor.tex
	pdflatex -interaction=batchmode gabor.tex && rm gabor.log gabor.aux

morlet.pdf: morlet.tex
	pdflatex -interaction=batchmode morlet.tex && rm morlet.log morlet.aux



im : im.cpp
	g++ -o im -Wall -O2 im.cpp -lpng16

# Search and replace section:

chirp_morlet.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 0, "chirp_morlet.dat") '
	./im -ichirp_morlet.dat -ochirp_morlet.png
	convert chirp_morlet.png -colorspace CMY -density 300 -units PixelsPerInch chirp_morlet.jpg
	pdflatex -interaction=batchmode -jobname=chirp_morlet '\newcommand{\imname}{chirp_morlet.jpg}\input{im.tex}'
	rm chirp_morlet.dat chirp_morlet.png chirp_morlet.jpg chirp_morlet.log chirp_morlet.aux

square_morlet.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 0, "square_morlet.dat") '
	./im -isquare_morlet.dat -osquare_morlet.png
	convert square_morlet.png -colorspace CMY -density 300 -units PixelsPerInch square_morlet.jpg
	pdflatex -interaction=batchmode -jobname=square_morlet '\newcommand{\imname}{square_morlet.jpg}\input{im.tex}'
	rm square_morlet.dat square_morlet.png square_morlet.jpg square_morlet.log square_morlet.aux

chirp_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 1, "chirp_haar.dat") '
	./im -ichirp_haar.dat -ochirp_haar.png
	convert chirp_haar.png -colorspace CMY -density 300 -units PixelsPerInch chirp_haar.jpg
	pdflatex -interaction=batchmode -jobname=chirp_haar '\newcommand{\imname}{chirp_haar.jpg}\input{im.tex}'
	rm chirp_haar.dat chirp_haar.png chirp_haar.jpg chirp_haar.log chirp_haar.aux

square_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 1, "square_haar.dat") '
	./im -isquare_haar.dat -osquare_haar.png
	convert square_haar.png -colorspace CMY -density 300 -units PixelsPerInch square_haar.jpg
	pdflatex -interaction=batchmode -jobname=square_haar '\newcommand{\imname}{square_haar.jpg}\input{im.tex}'
	rm square_haar.dat square_haar.png square_haar.jpg square_haar.log square_haar.aux

chirp_ahaar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 2, "chirp_ahaar.dat") '
	./im -ichirp_ahaar.dat -ochirp_ahaar.png
	convert chirp_ahaar.png -colorspace CMY -density 300 -units PixelsPerInch chirp_ahaar.jpg
	pdflatex -interaction=batchmode -jobname=chirp_ahaar '\newcommand{\imname}{chirp_ahaar.jpg}\input{im.tex}'
	rm chirp_ahaar.dat chirp_ahaar.png chirp_ahaar.jpg chirp_ahaar.log chirp_ahaar.aux

square_ahaar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 2, "square_ahaar.dat") '
	./im -isquare_ahaar.dat -osquare_ahaar.png
	convert square_ahaar.png -colorspace CMY -density 300 -units PixelsPerInch square_ahaar.jpg
	pdflatex -interaction=batchmode -jobname=square_ahaar '\newcommand{\imname}{square_ahaar.jpg}\input{im.tex}'
	rm square_ahaar.dat square_ahaar.png square_ahaar.jpg square_ahaar.log square_ahaar.aux

chirp_gabor.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 3, "chirp_gabor.dat") '
	./im -ichirp_gabor.dat -ochirp_gabor.png
	convert chirp_gabor.png -colorspace CMY -density 300 -units PixelsPerInch chirp_gabor.jpg
	pdflatex -interaction=batchmode -jobname=chirp_gabor '\newcommand{\imname}{chirp_gabor.jpg}\input{im.tex}'
	rm chirp_gabor.dat chirp_gabor.png chirp_gabor.jpg chirp_gabor.log chirp_gabor.aux

square_gabor.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 3, "square_gabor.dat") '
	./im -isquare_gabor.dat -osquare_gabor.png
	convert square_gabor.png -colorspace CMY -density 300 -units PixelsPerInch square_gabor.jpg
	pdflatex -interaction=batchmode -jobname=square_gabor '\newcommand{\imname}{square_gabor.jpg}\input{im.tex}'
	rm square_gabor.dat square_gabor.png square_gabor.jpg square_gabor.log square_gabor.aux

padding_none.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 3, 0, "padding_none.dat", 0, 0) '
	./im -ipadding_none.dat -opadding_none.png
	convert padding_none.png -colorspace CMY -density 300 -units PixelsPerInch padding_none.jpg
	pdflatex -interaction=batchmode -jobname=padding_none '\newcommand{\imname}{padding_none.jpg}\input{im.tex}'
	rm padding_none.dat padding_none.png padding_none.jpg padding_none.log padding_none.aux

padding_sym_conj.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 3, 0, "padding_sym_conj.dat", 1, 0) '
	./im -ipadding_sym_conj.dat -opadding_sym_conj.png
	convert padding_sym_conj.png -colorspace CMY -density 300 -units PixelsPerInch padding_sym_conj.jpg
	pdflatex -interaction=batchmode -jobname=padding_sym_conj '\newcommand{\imname}{padding_sym_conj.jpg}\input{im.tex}'
	rm padding_sym_conj.dat padding_sym_conj.png padding_sym_conj.jpg padding_sym_conj.log padding_sym_conj.aux

padding_zero.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 3, 0, "padding_zero.dat", 2, 0)'
	./im -ipadding_zero.dat -opadding_zero.png
	convert padding_zero.png -colorspace CMY -density 300 -units PixelsPerInch padding_zero.jpg
	pdflatex -interaction=batchmode -jobname=padding_zero '\newcommand{\imname}{padding_zero.jpg}\input{im.tex}'
	rm padding_zero.dat padding_zero.png padding_zero.jpg padding_zero.log padding_zero.aux

padding_sym.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 3, 0, "padding_sym.dat", 3, 0)'
	./im -ipadding_sym.dat -opadding_sym.png
	convert padding_sym.png -colorspace CMY -density 300 -units PixelsPerInch padding_sym.jpg
	pdflatex -interaction=batchmode -jobname=padding_sym '\newcommand{\imname}{padding_sym.jpg}\input{im.tex}'
	rm padding_sym.dat padding_sym.png padding_sym.jpg padding_sym.log padding_sym.aux



# add_cs_chirp.pdf: im im.m im.tex
# 	octave --silent --eval 'im(1920, 1080, 4, 0, "add_cs_chirp.dat")' 
# 	./im -iadd_cs_chirp.dat -oadd_cs_chirp.png
# 	convert add_cs_chirp.png -density 300 -units PixelsPerInch add_cs_chirp.jpg
# 	pdflatex -interaction=batchmode -jobname=add_cs_chirp '\newcommand{\imname}{add_cs_chirp.jpg}\input{im.tex}'
# 	rm add_cs_chirp.dat add_cs_chirp.png add_cs_chirp.jpg add_cs_chirp.log add_cs_chirp.aux
# 
# add_rs_square_haar.pdf: im im.m im.tex
# 	octave --silent --eval 'im(1920, 1080, 5, 1, "add_rs_square_haar.dat", 1, 0)' 
# 	./im -iadd_rs_square_haar.dat -oadd_rs_square_haar.png
# 	convert add_rs_square_haar.png -density 300 -units PixelsPerInch add_rs_square_haar.jpg
# 	pdflatex -interaction=batchmode -jobname=add_rs_square_haar '\newcommand{\imname}{add_rs_square_haar.jpg}\input{im.tex}'
# 	rm add_rs_square_haar.dat add_rs_square_haar.png add_rs_square_haar.jpg add_rs_square_haar.log add_rs_square_haar.aux
# 
# add_cs_haar_chirp.pdf: im im.m im.tex
# 	octave --silent --eval 'im(1920, 1080, 6, 1, "add_cs_haar_chirp.dat", 1, 0)' 
# 	./im -iadd_cs_haar_chirp.dat -oadd_cs_haar_chirp.png
# 	convert add_cs_haar_chirp.png -density 300 -units PixelsPerInch add_cs_haar_chirp.jpg
# 	pdflatex -interaction=batchmode -jobname=add_cs_haar_chirp '\newcommand{\imname}{add_cs_haar_chirp.jpg}\input{im.tex}'
# 	rm add_cs_haar_chirp.dat add_cs_haar_chirp.png add_cs_haar_chirp.jpg add_cs_haar_chirp.log add_cs_haar_chirp.aux
# 
# test.pdf: im im.m im.tex
# 	octave --silent --eval 'im(1920, 1080, 4, 0, "test.dat", 1, 1)' 
# 	./im -itest.dat -otest.png
# 	convert test.png -density 300 -units PixelsPerInch test.jpg
# 	pdflatex -interaction=batchmode -jobname=test '\newcommand{\imname}{test.jpg}\input{im.tex}'
# 	rm test.dat test.png test.jpg test.log test.aux

