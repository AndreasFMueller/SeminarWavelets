#
# db1.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

# db1

J = 9;

h = [ 1,  1 ]

Wphi("phi-db1.tex", h, J, "blue");
Wpsi("psi-db1.tex", h, J, "red");

