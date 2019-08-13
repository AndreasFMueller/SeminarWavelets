#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
# (c) 2019 Roy Seitz, Hochschule Rapperswil
#
.PHONY: all images clean
MAKEFLAGS+=" -j 8"

all:
images:	ahaar.pdf haar.pdf haar_dom.pdf gabor.pdf morlet.pdf \
	signals.pdf signal_padding.pdf \
	cyclic_conv.pdf colors.pdf \
	chirp_morlet.pdf square_morlet.pdf \
	chirp_haar.pdf square_haar.pdf \
	chirp_ahaar.pdf square_ahaar.pdf \
	chirp_gabor.pdf square_gabor.pdf \
	padding_none_sweep.pdf padding_none_square.pdf \
	padding_zero_sweep.pdf padding_zero_square.pdf \
	padding_sym_sweep.pdf padding_sym_square.pdf \
	add_cs_chirp_haar.pdf \
	add_rs_chirp_haar.pdf \
	add_rs_chirp_morlet.pdf \
	add_rs_square_morlet.pdf \
	add_nc_chirp_haar.pdf \
	add_nc_square_haar.pdf


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


colors.pdf: im colors.m colors.tex
	octave --silent --eval 'colors(1024, 1024, "colors.dat") '
	./im -icolors.dat -ocolors.png
	convert colors.png -density 300 -units PixelsPerInch colors.jpg
	pdflatex -interaction=batchmode colors.tex
	rm colors.dat colors.png colors.jpg colors.log colors.aux

# Search and replace section:

chirp_morlet.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 0, "chirp_morlet.dat")'
	./im -ichirp_morlet.dat -ochirp_morlet.png
	convert chirp_morlet.png -density 300 -units PixelsPerInch chirp_morlet.jpg
	pdflatex -interaction=batchmode -jobname=chirp_morlet '\newcommand{\imname}{chirp_morlet.jpg}\input{im.tex}'
	rm chirp_morlet.dat chirp_morlet.png chirp_morlet.jpg chirp_morlet.log chirp_morlet.aux

square_morlet.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 0, "square_morlet.dat")'
	./im -isquare_morlet.dat -osquare_morlet.png
	convert square_morlet.png -density 300 -units PixelsPerInch square_morlet.jpg
	pdflatex -interaction=batchmode -jobname=square_morlet '\newcommand{\imname}{square_morlet.jpg}\input{im.tex}'
	rm square_morlet.dat square_morlet.png square_morlet.jpg square_morlet.log square_morlet.aux

chirp_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 1, "chirp_haar.dat")'
	./im -ichirp_haar.dat -ochirp_haar.png
	convert chirp_haar.png -density 300 -units PixelsPerInch chirp_haar.jpg
	pdflatex -interaction=batchmode -jobname=chirp_haar '\newcommand{\imname}{chirp_haar.jpg}\input{im.tex}'
	rm chirp_haar.dat chirp_haar.png chirp_haar.jpg chirp_haar.log chirp_haar.aux

square_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 1, "square_haar.dat")'
	./im -isquare_haar.dat -osquare_haar.png
	convert square_haar.png -density 300 -units PixelsPerInch square_haar.jpg
	pdflatex -interaction=batchmode -jobname=square_haar '\newcommand{\imname}{square_haar.jpg}\input{im.tex}'
	rm square_haar.dat square_haar.png square_haar.jpg square_haar.log square_haar.aux

chirp_ahaar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 2, "chirp_ahaar.dat")'
	./im -ichirp_ahaar.dat -ochirp_ahaar.png
	convert chirp_ahaar.png -density 300 -units PixelsPerInch chirp_ahaar.jpg
	pdflatex -interaction=batchmode -jobname=chirp_ahaar '\newcommand{\imname}{chirp_ahaar.jpg}\input{im.tex}'
	rm chirp_ahaar.dat chirp_ahaar.png chirp_ahaar.jpg chirp_ahaar.log chirp_ahaar.aux

square_ahaar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 2, "square_ahaar.dat")'
	./im -isquare_ahaar.dat -osquare_ahaar.png
	convert square_ahaar.png -density 300 -units PixelsPerInch square_ahaar.jpg
	pdflatex -interaction=batchmode -jobname=square_ahaar '\newcommand{\imname}{square_ahaar.jpg}\input{im.tex}'
	rm square_ahaar.dat square_ahaar.png square_ahaar.jpg square_ahaar.log square_ahaar.aux

chirp_gabor.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 3, "chirp_gabor.dat")'
	./im -ichirp_gabor.dat -ochirp_gabor.png
	convert chirp_gabor.png -density 300 -units PixelsPerInch chirp_gabor.jpg
	pdflatex -interaction=batchmode -jobname=chirp_gabor '\newcommand{\imname}{chirp_gabor.jpg}\input{im.tex}'
	rm chirp_gabor.dat chirp_gabor.png chirp_gabor.jpg chirp_gabor.log chirp_gabor.aux

square_gabor.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 3, "square_gabor.dat")'
	./im -isquare_gabor.dat -osquare_gabor.png
	convert square_gabor.png -density 300 -units PixelsPerInch square_gabor.jpg
	pdflatex -interaction=batchmode -jobname=square_gabor '\newcommand{\imname}{square_gabor.jpg}\input{im.tex}'
	rm square_gabor.dat square_gabor.png square_gabor.jpg square_gabor.log square_gabor.aux

padding_none_sweep.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 0, "padding_none_sweep.dat", 0, 0)'
	./im -ipadding_none_sweep.dat -opadding_none_sweep.png
	convert padding_none_sweep.png -density 300 -units PixelsPerInch padding_none_sweep.jpg
	pdflatex -interaction=batchmode -jobname=padding_none_sweep '\newcommand{\imname}{padding_none_sweep.jpg}\input{im.tex}'
	rm padding_none_sweep.dat padding_none_sweep.png padding_none_sweep.jpg padding_none_sweep.log padding_none_sweep.aux

padding_none_square.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 0, "padding_none_square.dat", 0, 0)'
	./im -ipadding_none_square.dat -opadding_none_square.png
	convert padding_none_square.png -density 300 -units PixelsPerInch padding_none_square.jpg
	pdflatex -interaction=batchmode -jobname=padding_none_square '\newcommand{\imname}{padding_none_square.jpg}\input{im.tex}'
	rm padding_none_square.dat padding_none_square.png padding_none_square.jpg padding_none_square.log padding_none_square.aux

padding_zero_sweep.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 0, "padding_zero_sweep.dat", 2, 0)'
	./im -ipadding_zero_sweep.dat -opadding_zero_sweep.png
	convert padding_zero_sweep.png -density 300 -units PixelsPerInch padding_zero_sweep.jpg
	pdflatex -interaction=batchmode -jobname=padding_zero_sweep '\newcommand{\imname}{padding_zero_sweep.jpg}\input{im.tex}'
	rm padding_zero_sweep.dat padding_zero_sweep.png padding_zero_sweep.jpg padding_zero_sweep.log padding_zero_sweep.aux

padding_zero_square.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 0, "padding_zero_square.dat", 2, 0)'
	./im -ipadding_zero_square.dat -opadding_zero_square.png
	convert padding_zero_square.png -density 300 -units PixelsPerInch padding_zero_square.jpg
	pdflatex -interaction=batchmode -jobname=padding_zero_square '\newcommand{\imname}{padding_zero_square.jpg}\input{im.tex}'
	rm padding_zero_square.dat padding_zero_square.png padding_zero_square.jpg padding_zero_square.log padding_zero_square.aux

padding_sym_sweep.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 0, "padding_sym_sweep.dat", 1, 0)'
	./im -ipadding_sym_sweep.dat -opadding_sym_sweep.png
	convert padding_sym_sweep.png -density 300 -units PixelsPerInch padding_sym_sweep.jpg
	pdflatex -interaction=batchmode -jobname=padding_sym_sweep '\newcommand{\imname}{padding_sym_sweep.jpg}\input{im.tex}'
	rm padding_sym_sweep.dat padding_sym_sweep.png padding_sym_sweep.jpg padding_sym_sweep.log padding_sym_sweep.aux

padding_sym_square.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 0, "padding_sym_square.dat", 1, 0)'
	./im -ipadding_sym_square.dat -opadding_sym_square.png
	convert padding_sym_square.png -density 300 -units PixelsPerInch padding_sym_square.jpg
	pdflatex -interaction=batchmode -jobname=padding_sym_square '\newcommand{\imname}{padding_sym_square.jpg}\input{im.tex}'
	rm padding_sym_square.dat padding_sym_square.png padding_sym_square.jpg padding_sym_square.log padding_sym_square.aux

add_rs_chirp_morlet.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 4, 0, "add_rs_chirp_morlet.dat", 1, 0)'
	./im -iadd_rs_chirp_morlet.dat -oadd_rs_chirp_morlet.png
	convert add_rs_chirp_morlet.png -density 300 -units PixelsPerInch add_rs_chirp_morlet.jpg
	pdflatex -interaction=batchmode -jobname=add_rs_chirp_morlet '\newcommand{\imname}{add_rs_chirp_morlet.jpg}\input{im.tex}'
	rm add_rs_chirp_morlet.dat add_rs_chirp_morlet.png add_rs_chirp_morlet.jpg add_rs_chirp_morlet.log add_rs_chirp_morlet.aux

add_rs_square_morlet.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 5, 0, "add_rs_square_morlet.dat", 1, 0)'
	./im -iadd_rs_square_morlet.dat -oadd_rs_square_morlet.png
	convert add_rs_square_morlet.png -density 300 -units PixelsPerInch add_rs_square_morlet.jpg
	pdflatex -interaction=batchmode -jobname=add_rs_square_morlet '\newcommand{\imname}{add_rs_square_morlet.jpg}\input{im.tex}'
	rm add_rs_square_morlet.dat add_rs_square_morlet.png add_rs_square_morlet.jpg add_rs_square_morlet.log add_rs_square_morlet.aux

add_rs_chirp_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 4, 1, "add_rs_chirp_haar.dat", 1, 0)'
	./im -iadd_rs_chirp_haar.dat -oadd_rs_chirp_haar.png
	convert add_rs_chirp_haar.png -density 300 -units PixelsPerInch add_rs_chirp_haar.jpg
	pdflatex -interaction=batchmode -jobname=add_rs_chirp_haar '\newcommand{\imname}{add_rs_chirp_haar.jpg}\input{im.tex}'
	rm add_rs_chirp_haar.dat add_rs_chirp_haar.png add_rs_chirp_haar.jpg add_rs_chirp_haar.log add_rs_chirp_haar.aux

add_cs_chirp_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 6, 1, "add_cs_chirp_haar.dat", 1, 0)'
	./im -iadd_cs_chirp_haar.dat -oadd_cs_chirp_haar.png
	convert add_cs_chirp_haar.png -density 300 -units PixelsPerInch add_cs_chirp_haar.jpg
	pdflatex -interaction=batchmode -jobname=add_cs_chirp_haar '\newcommand{\imname}{add_cs_chirp_haar.jpg}\input{im.tex}'
	rm add_cs_chirp_haar.dat add_cs_chirp_haar.png add_cs_chirp_haar.jpg add_cs_chirp_haar.log add_cs_chirp_haar.aux

add_nc_chirp_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 8, 0, "add_nc_chirp_haar.dat")'
	./im -iadd_nc_chirp_haar.dat -oadd_nc_chirp_haar.png
	convert add_nc_chirp_haar.png -density 300 -units PixelsPerInch add_nc_chirp_haar.jpg
	pdflatex -interaction=batchmode -jobname=add_nc_chirp_haar '\newcommand{\imname}{add_nc_chirp_haar.jpg}\input{im.tex}'
	rm add_nc_chirp_haar.dat add_nc_chirp_haar.png add_nc_chirp_haar.jpg add_nc_chirp_haar.log add_nc_chirp_haar.aux

add_nc_square_haar.pdf: im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 9, 0, "add_nc_square_haar.dat")'
	./im -iadd_nc_square_haar.dat -oadd_nc_square_haar.png
	convert add_nc_square_haar.png -density 300 -units PixelsPerInch add_nc_square_haar.jpg
	pdflatex -interaction=batchmode -jobname=add_nc_square_haar '\newcommand{\imname}{add_nc_square_haar.jpg}\input{im.tex}'
	rm add_nc_square_haar.dat add_nc_square_haar.png add_nc_square_haar.jpg add_nc_square_haar.log add_nc_square_haar.aux



