#
# Makefile
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	db1.pdf db2.pdf db3.pdf db4.pdf

db1.pdf:	db1.tex phi-db1.tex psi-db1.tex
	pdflatex db1.tex

db2.pdf:	db2.tex phi-db2.tex psi-db2.tex
	pdflatex db2.tex

db3.pdf:	db3.tex phi-db3.tex psi-db3.tex
	pdflatex db3.tex

db4.pdf:	db4.tex phi-db4.tex psi-db4.tex
	pdflatex db4.tex

curves =			\
	phi-db1.tex pxi-db1.tex	\
	phi-db2.tex pxi-db2.tex	\
	phi-db3.tex pxi-db3.tex	\
	phi-db4.tex pxi-db4.tex

$(curves):	tsaf.m
	octave tsaf.m
