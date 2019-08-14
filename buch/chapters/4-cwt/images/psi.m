#
# psi.m -- Wavelet Transformation der Sin-Funktion
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
bstep = pi/30
bmin = bstep * floor(-2 / bstep);
bmax = 12;

Astep = pi/15
Amin = 0.1;
Amax = 20;

f = fopen("psidots.tex", "w");

for (b = (bmin:bstep:bmax))
	for (A = (Amin:Astep:Amax))
		a = 2^(A - 2);
		a = A;
		w = (2*cos(b) - cos(b+a) - cos(b-a));
		#w = abs(w) / sqrt(2*a);
		w = w / sqrt(2*a);
		w = w * sqrt(2*pi)/4;
		w = round(100 * w);
		fprintf(f, "\\punkt{%.3f}{%.3f}{%.0f}\n", A, b, w);
	endfor
endfor

fclose(f);

