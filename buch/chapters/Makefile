#
# Makefile -- build the stuff used in support of the theory part of the book
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
CHAPTERS = 								\
	0-einleitung							\
	1-geometrie							\
	2-fourier							\
	3-haar								\
	4-cwt								\
	5-shannon							\
	6-msa								\
	7-algo								\
	8-kompakt							\
	9-spline							\
	a-komplex

images:
	@for d in ${CHAPTERS};						\
	do								\
		(							\
			if [ -f $${d}/Makefile ];			\
			then						\
				echo "make images in $${d}";		\
				cd $${d};				\
				make images;				\
			fi;						\
		);							\
	done
