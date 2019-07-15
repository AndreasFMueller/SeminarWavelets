#
# coif2.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

#
# Coiflet
#

J = 9;

h = [ -0.0007205494, -0.0018232089, 0.0056114348, 0.0236801719, -0.0594344186, -0.0764885991, 0.4170051844, 0.8127236354, 0.3861100668, -0.0673725547, -0.0414649368, 0.0163873365 ]
h = sqrt(2) * fliplr(h);

Wphi("phi-coif2.tex", h, J, "blue");
Wpsi("psi-coif2.tex", h, J, "red");


