#
# Makefile
#
all: sinsweep-clipped.jpg sweepdwt-clipped.jpg

format=6000x4220+220+500
formats=8200x5800+800+800

sinsweep-clipped.jpg: sinsweep.jpg Makefile
	convert -extract $(format) sinsweep.jpg \
		-density 300 -units PixelsPerInch sinsweep-clipped.jpg

sweepdwt-clipped.jpg: sweepdwt.jpg Makefile
	convert -extract $(formats) sweepdwt.jpg \
		-density 300 -units PixelsPerInch sweepdwt-clipped.jpg
