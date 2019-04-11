#
# db4.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

# db4

J = 9;

h = [ 0.32580343, 1.01094572, 0.8922014, -0.03967503, -0.26450717, 0.0436163, 0.0465036, -0.01498699 ]

Wphi("phi-db4.tex", h, J, "blue");
Wpsi("psi-db4.tex", h, J, "red");

