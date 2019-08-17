#
# Makefile -- improve images
#
all:	signal-clipped.jpg		\
	stft256-clipped.jpg		\
	stft1024-clipped.jpg		\
	stft4096-clipped.jpg		\
	stft8192-clipped.jpg

format=3070x2460+195+183

signal-clipped.jpg:	signal.jpg Makefile
	convert -extract 7280x2275+1000+182 signal.jpg \
		-density 300 -units PixelsPerInch signal-clipped.jpg


stft256-clipped.jpg: stft256.jpg Makefile
	convert -extract $(format) stft256.jpg \
		-density 300 -units PixelsPerInch stft256-clipped.jpg

stft1024-clipped.jpg: stft1024.jpg Makefile
	convert -extract $(format) stft1024.jpg \
		-density 300 -units PixelsPerInch stft1024-clipped.jpg

stft4096-clipped.jpg: stft4096.jpg Makefile
	convert -extract $(format) stft4096.jpg \
		-density 300 -units PixelsPerInch stft4096-clipped.jpg

stft8192-clipped.jpg: stft8192.jpg Makefile
	convert -extract $(format) stft8192.jpg \
		-density 300 -units PixelsPerInch stft8192-clipped.jpg
