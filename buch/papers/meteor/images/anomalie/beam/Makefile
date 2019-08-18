#
# Makefile - clip images
#
all:	cwt_0100hz-clipped.png \
	cwt_0500hz-clipped.png \
	cwt_1000hz-clipped.png \
	cwt_1200hz-clipped.png

format=1660x792+198+88

cwt_0100hz-clipped.png: cwt_0100hz.png Makefile
	convert -extract $(format) cwt_0100hz.png \
		-density 300 -units PixelsPerInch cwt_0100hz-clipped.png

cwt_0500hz-clipped.png: cwt_0500hz.png Makefile
	convert -extract $(format) cwt_0500hz.png \
		-density 300 -units PixelsPerInch cwt_0500hz-clipped.png

cwt_1000hz-clipped.png: cwt_1000hz.png Makefile
	convert -extract $(format) cwt_1000hz.png \
		-density 300 -units PixelsPerInch cwt_1000hz-clipped.png

cwt_1200hz-clipped.png: cwt_1200hz.png Makefile
	convert -extract $(format) cwt_1200hz.png \
		-density 300 -units PixelsPerInch cwt_1200hz-clipped.png


