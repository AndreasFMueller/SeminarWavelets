#
# db5.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

# db5

J = 9;

h = [ 0.0033357253, -0.0125807520, -0.0062414902, 0.0775714938, -0.0322448696, -0.2422948871, 0.1384281459, 0.7243085284, 0.6038292698, 0.1601023980 ];
h = sqrt(2) * fliplr(h);

Wphi("phi-db5.tex", h, J, "blue");
Wpsi("psi-db5.tex", h, J, "red");

