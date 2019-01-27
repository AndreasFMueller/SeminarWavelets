#
# Makefile -- build some supporting stuff
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	addbibresources.tex addpackages.tex addpapers.tex Makefile.inc

addbibresources.tex:	paperlist mkbibresources
	bash mkbibresources

addpackages.tex:	paperlist mkpackages
	bash mkpackages

addpapers.tex:	paperlist mkpapers
	bash mkpapers

Makefile.inc:	paperlist mkmk
	bash mkmk
