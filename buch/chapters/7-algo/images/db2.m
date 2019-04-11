#
# db2.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

# db2

J = 9;

h = [ 0.6830127, 1.1830127, 0.3169873, -0.1830127 ];

Wphi("phi-db2.tex", h, J, "blue");
Wpsi("psi-db2.tex", h, J, "red");

