#
# Makefile
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	db1.pdf db2.pdf db3.pdf db4.pdf db5.pdf \
	coif1.pdf coif2.pdf coif3.pdf coif4.pdf coif5.pdf \
	approx.pdf fastalgo.pdf

db1.pdf:	db1.tex phi-db1.tex psi-db1.tex
	pdflatex db1.tex

db2.pdf:	db2.tex phi-db2.tex psi-db2.tex
	pdflatex db2.tex

db3.pdf:	db3.tex phi-db3.tex psi-db3.tex
	pdflatex db3.tex

db4.pdf:	db4.tex phi-db4.tex psi-db4.tex
	pdflatex db4.tex

db5.pdf:	db5.tex phi-db5.tex psi-db5.tex
	pdflatex db5.tex

coif1.pdf:	coif1.tex phi-coif1.tex psi-coif1.tex
	pdflatex coif1.tex

coif2.pdf:	coif2.tex phi-coif2.tex psi-coif2.tex
	pdflatex coif2.tex

coif3.pdf:	coif3.tex phi-coif3.tex psi-coif3.tex
	pdflatex coif3.tex

coif4.pdf:	coif4.tex phi-coif4.tex psi-coif4.tex
	pdflatex coif4.tex

coif5.pdf:	coif5.tex phi-coif5.tex psi-coif5.tex
	pdflatex coif5.tex

phi-db1.tex psi-db1.tex:	db1.m Winverse.m
	octave db1.m

phi-db2.tex psi-db2.tex:	db2.m Winverse.m
	octave db2.m

phi-db3.tex psi-db3.tex:	db3.m Winverse.m
	octave db3.m

phi-db4.tex psi-db4.tex:	db4.m Winverse.m
	octave db4.m

phi-db5.tex psi-db5.tex:	db5.m Winverse.m
	octave db5.m

phi-coif1.tex psi-coif1.tex:	coif1.m Winverse.m
	octave coif1.m

phi-coif2.tex psi-coif2.tex:	coif2.m Winverse.m
	octave coif2.m

phi-coif3.tex psi-coif3.tex:	coif3.m Winverse.m
	octave coif3.m

phi-coif4.tex psi-coif4.tex:	coif4.m Winverse.m
	octave coif4.m

phi-coif5.tex psi-coif5.tex:	coif5.m Winverse.m
	octave coif5.m

approx.pdf:	approx.tex phi-approx.tex psi-approx.tex
	pdflatex approx.tex

phi-approx.tex psi-approx.tex:	approx.m
	octave approx.m

fastalgo.pdf:	fastalgo.tex
	pdflatex fastalgo.tex


