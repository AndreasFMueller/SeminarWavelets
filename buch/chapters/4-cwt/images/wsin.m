#
# wsin.m -- Wavelet Transformation der Sin-Funktion
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
bmin = -2;
bmax = 12;
bstep = 0.1;

amin = 0.1;
astep = 0.1;
amax = 5;

f = fopen("wsindots.tex", "w");

for (b = (bmin:bstep:bmax))
	for (a = (amin:astep:amax))
		w = (2 * cos(0.5*a+b) - cos(a + b) - 1)/sqrt(a);
		w = round(100 * abs(w));
		fprintf(f, "\\punkt{%.1f}{%.1f}{%.0f}\n", a, b, w);
	endfor
endfor

fclose(f);

