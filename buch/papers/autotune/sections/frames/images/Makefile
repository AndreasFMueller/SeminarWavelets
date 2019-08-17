#
# Makefile
#
all:	cwtmaxima-clipped.jpg \
	Overlaid/dwtmaxima-clipped.jpg Stacked/dwtmaxima-clipped.jpg \
	cwt-clipped.jpg \
	Stacked/12dwt-clipped.jpg Stacked/48dwt-clipped.jpg \
	Overlaid/7040Hz12dwt-clipped.jpg Overlaid/7040Hz48dwt-clipped.jpg

format=4408x1480+304+90
formato=4308x1480+304+90

cwtmaxima-clipped.jpg: cwtmaxima.jpg Makefile
	convert -extract $(format) cwtmaxima.jpg \
		-density 300 -units PixelsPerInch cwtmaxima-clipped.jpg
Overlaid/dwtmaxima-clipped.jpg: Overlaid/dwtmaxima.jpg Makefile
	convert -extract $(formato) Overlaid/dwtmaxima.jpg \
		-density 300 -units PixelsPerInch Overlaid/dwtmaxima-clipped.jpg
Stacked/dwtmaxima-clipped.jpg: Stacked/dwtmaxima.jpg Makefile
	convert -extract $(format) Stacked/dwtmaxima.jpg \
		-density 300 -units PixelsPerInch Stacked/dwtmaxima-clipped.jpg

format1=6100x4220+220+500
#format2=8200x5800+800+800
format2=9150x6330+330+750


cwt-clipped.jpg: cwt.jpg Makefile
	convert -extract $(format1) cwt.jpg \
		-density 300 -units PixelsPerInch cwt-clipped.jpg

Stacked/12dwt-clipped.jpg: Stacked/12dwt.jpg Makefile
	convert -extract $(format2) Stacked/12dwt.jpg \
		-density 300 -units PixelsPerInch Stacked/12dwt-clipped.jpg
Stacked/48dwt-clipped.jpg: Stacked/48dwt.jpg Makefile
	convert -extract $(format2) Stacked/48dwt.jpg \
		-density 300 -units PixelsPerInch Stacked/48dwt-clipped.jpg
Overlaid/7040Hz12dwt-clipped.jpg: Overlaid/7040Hz12dwt.jpg Makefile
	convert -extract $(format1) Overlaid/7040Hz12dwt.jpg \
		-density 300 -units PixelsPerInch Overlaid/7040Hz12dwt-clipped.jpg
Overlaid/7040Hz48dwt-clipped.jpg: Overlaid/7040Hz48dwt.jpg Makefile
	convert -extract $(format1) Overlaid/7040Hz48dwt.jpg \
		-density 300 -units PixelsPerInch Overlaid/7040Hz48dwt-clipped.jpg
