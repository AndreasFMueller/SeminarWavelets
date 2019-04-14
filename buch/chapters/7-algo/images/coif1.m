#
# coif1.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

#
# Coiflet
#

J = 9;

h = [ -0.0156557281, -0.0727326195, 0.3848648469, 0.8525720202, 0.3378976625, -0.0727326195 ];
h = sqrt(2) * fliplr(h);

Wphi("phi-coif1.tex", h, J, "blue");
Wpsi("psi-coif1.tex", h, J, "red");


