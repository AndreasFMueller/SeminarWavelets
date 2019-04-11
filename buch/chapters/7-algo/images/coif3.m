#
# coif3.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

#
# Coiflet 3
#

J = 9;

h = [ -0.0000345998, -0.0000709833, 0.0004662170, 0.0011175188, -0.0025745177, -0.0090079761, 0.0158805449, 0.0345550276, -0.0823019271, -0.0717998216, 0.4284834764, 0.7937772226, 0.4051769024, -0.0611233900, -0.0657719113, 0.0234526961, 0.0077825964, -0.0037935129 ];
h = sqrt(2) * fliplr(h);

Wphi("phi-coif3.tex", h, J, "blue");
Wpsi("psi-coif3.tex", h, J, "red");


