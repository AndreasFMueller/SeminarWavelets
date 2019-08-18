#
# Makefile - clip images
#
all:	cwt_0100to0300hz-clipped.png \
	cwt_0500to0700hz-clipped.png \
	cwt_0900to1100hz-clipped.png \
	cwt_2200to2400hz-clipped.png

format=1660x792+198+88

cwt_0100to0300hz-clipped.png: cwt_0100to0300hz.png Makefile
	convert -extract $(format) cwt_0100to0300hz.png \
		-density 300 -units PixelsPerInch cwt_0100to0300hz-clipped.png

cwt_0500to0700hz-clipped.png: cwt_0500to0700hz.png Makefile
	convert -extract $(format) cwt_0500to0700hz.png \
		-density 300 -units PixelsPerInch cwt_0500to0700hz-clipped.png

cwt_0900to1100hz-clipped.png: cwt_0900to1100hz.png Makefile
	convert -extract $(format) cwt_0900to1100hz.png \
		-density 300 -units PixelsPerInch cwt_0900to1100hz-clipped.png

cwt_2200to2400hz-clipped.png: cwt_2200to2400hz.png Makefile
	convert -extract $(format) cwt_2200to2400hz.png \
		-density 300 -units PixelsPerInch cwt_2200to2400hz-clipped.png


