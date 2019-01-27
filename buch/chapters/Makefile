#
# Makefile -- build the stuff used in support of the theory part of the book
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
CHAPTERS = 

images:
	for d in ${CHAPTERS};						\
	do								\
		(cd $${d}; if [ -f Makefile ]; then make images; fi);	\
	done
