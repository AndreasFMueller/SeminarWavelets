#
# db3.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

# db3

J = 9;

h = [ 0.47046721, 1.14111692, 0.650365, -0.19093442, -0.12083221, 0.0498175 ];

Wphi("phi-db3.tex", h, J, "blue");
Wpsi("psi-db3.tex", h, J, "red");

