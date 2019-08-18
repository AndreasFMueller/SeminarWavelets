#
# Makefile -- fix image dimensions
#
all: signal_gfft-clipped.png signal_wscalo-clipped.png

format=1390x530+164+40

signal_gfft-clipped.png: signal_gfft.png Makefile
	convert -extract $(format) signal_gfft.png \
		-density 300 -units PixelsPerInch signal_gfft-clipped.png

format2=1490x542+172+52

signal_wscalo-clipped.png: signal_wscalo.png Makefile
	convert -extract $(format2) signal_wscalo.png \
		-density 300 -units PixelsPerInch signal_wscalo-clipped.png

