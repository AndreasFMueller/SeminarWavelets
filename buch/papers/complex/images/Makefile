#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
# (c) 2019 Roy Seitz, Hochschule Rapperswil
#
imfiles = im.dat im.png im.jpg im.aux im.log

all:	images
images:	haar.pdf gabor.pdf morlet.pdf \
	chirp_morlet.pdf square_morlet.pdf \
	chirp_haar.pdf square_haar.pdf \
	chirp_ahaar.pdf square_ahaar.pdf \
	chirp_gabor.pdf square_gabor.pdf
clean:
	rm -rf *.aux *.data *.log haar.pdf morlet.pdf gabor.pdf \
	im im.png $(imfiles) \
	chirp_morlet.pdf square_morlet.pdf chirp_haar.pdf square_haar.pdf


haar.pdf:	haar.tex haar.data
	pdflatex -interaction=batchmode haar.tex

haar.data:	haar.m
	octave haar.m

gabor.pdf:	gabor.tex gabor.data
	pdflatex -interaction=batchmode gabor.tex

gabor.data:	gabor.m
	octave gabor.m

morlet.pdf:	morlet.tex morlet.data
	pdflatex -interaction=batchmode morlet.tex

morlet.data:	morlet.m
	octave morlet.m

im :	im.cpp
	g++ -o im -Wall -O2 im.cpp -lpng16

chirp_morlet.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 0, 0, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_morlet.pdf && rm $(imfiles)

square_morlet.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 1, 0, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_morlet.pdf && rm $(imfiles)

chirp_haar.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 0, 1, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_haar.pdf && rm $(imfiles)

square_haar.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 1, 1, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_haar.pdf && rm $(imfiles)

chirp_ahaar.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 0, 2, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_ahaar.pdf && rm $(imfiles)

square_ahaar.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 1, 2, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_ahaar.pdf && rm $(imfiles)

chirp_gabor.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 0, 3, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf chirp_gabor.pdf && rm $(imfiles)

square_gabor.pdf:	im im.m
	octave --silent --eval 'im(1920, 1080, 1, 3, 1, 0, 1)' 
	./im 
	convert im.png -density 300 -units PixelsPerInch im.jpg 
	pdflatex -interaction=batchmode im.tex 
	mv im.pdf square_gabor.pdf && rm $(imfiles)

