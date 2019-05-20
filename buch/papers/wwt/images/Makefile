#
# Makefile -- build auxiliary data
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	raw_airp_wwt.pdf raw_temp_wwt.pdf raw_wind_wwt.pdf raw_rain_wwt.pdf
clean:
	rm -rf *.aux *.data *.log raw_airp_wwt.pdf raw_temp_wwt.pdf raw_wind_wwt.pdf raw_rain_wwt.pdf

images:	raw_airp_wwt.pdf raw_temp_wwt.pdf raw_wind_wwt.pdf raw_rain_wwt.pdf

raw_airp_wwt.pdf:	raw_airp_wwt.tex
	pdflatex raw_airp_wwt.tex

raw_temp_wwt.pdf:	raw_temp_wwt.tex
	pdflatex raw_temp_wwt.tex

raw_rain_wwt.pdf:	raw_rain_wwt.tex
	pdflatex raw_rain_wwt.tex

raw_wind_wwt.pdf:	raw_wind_wwt.tex
	pdflatex raw_wind_wwt.tex

