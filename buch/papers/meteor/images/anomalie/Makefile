#
# Makefile -- fix image dimensions
#
all:	cwt_signal_scale1to20-clipped.png

format=1660x792+198+88

cwt_signal_scale1to20-clipped.png: cwt_signal_scale1to20.png Makefile
	convert -extract $(format) cwt_signal_scale1to20.png \
		-density 300 -units PixelsPerInch cwt_signal_scale1to20-clipped.png

