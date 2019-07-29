#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
# (c) 2019 Roy Seitz, Hochschule Rapperswil
#
imfiles = im.dat im.png im.jpg square.aux square.log chirp.aux chirp.log

all:	
images:	haar.pdf gabor.pdf morlet.pdf \
	chirp_morlet.pdf square_morlet.pdf \
	chirp_haar.pdf square_haar.pdf \
	chirp_ahaar.pdf square_ahaar.pdf \
	chirp_gabor.pdf square_gabor.pdf
clean:
	rm -rf *.aux *.log $(imfiles)


haar.pdf:	haar.tex
	pdflatex -interaction=batchmode haar.tex

gabor.pdf:	gabor.tex
	pdflatex -interaction=batchmode gabor.tex

morlet.pdf:	morlet.tex
	pdflatex -interaction=batchmode morlet.tex

im :	im.cpp
	g++ -o im -Wall -O2 im.cpp -lpng16

chirp_morlet.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 0, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_morlet.pdf

square_morlet.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 0, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_morlet.pdf

chirp_haar.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 1, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_haar.pdf

square_haar.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 1, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_haar.pdf

chirp_ahaar.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 2, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_ahaar.pdf

square_ahaar.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 2, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_ahaar.pdf

chirp_gabor.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 0, 3, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_gabor.pdf

square_gabor.pdf:	im im.m im.tex
	octave --silent --eval 'im(1920, 1080, 1, 3, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_gabor.pdf

