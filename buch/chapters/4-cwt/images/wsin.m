#
# wsin.m -- Wavelet Transformation der Sin-Funktion
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
bmin = -2;
bmax = 12;
bstep = 0.1;

amin = 0.25;
astep = 0.5;
amax = 30;

f = fopen("wsindots.tex", "w");

for (b = (bmin:bstep:bmax))
	for (a = (amin:astep:amax))
		w = (2 * cos(0.5*a+b) - cos(a + b) - 1)/sqrt(a);
		w = round(100 * abs(w));
		fprintf(f, "\\punkt{%.3f}{%.3f}{%.0f}\n", a/5, b, w);
	endfor
endfor

fclose(f);

