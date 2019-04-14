#
# approx.m
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
source("Winverse.m");

h = [ 0.6830127, 1.1830127, 0.3169873, -0.1830127 ];

l = size(h)(2);

f = fopen("phi-approx.tex", "w");

for J = (1:9)
	fprintf(f, "%% db1 with J=%d\n", J);
	N = l * 2^J;
	a = zeros(2, N);
	b = zeros(2, N);
	a(1,1) = 1;
	a = Winverse(a, b, h, J);
	delta = 2^(-J);
	y = 0;
	for k = (0:N-1)
		x = k * delta;
		y = a(2, k+1);
		if (x + delta/2) < 3
			fprintf(f, "\\draw[line width=1pt,color=blue!%d] (%.5f,%.5f)--(%.5f,%.5f);\n", 8*J + 28, x, y, x + delta, y);
		end
	end
end

fclose(f);

f = fopen("psi-approx.tex", "w");

for J = (1:9)
	fprintf(f, "%% db1 with J=%d\n", J);
	N = l * 2^J;
	a = zeros(2, N);
	b = zeros(2, N);
	b(1,1) = 1;
	a = Winverse(a, b, h, J);
	delta = 2^(-J);
	y = 0;
	for k = (0:N-1)
		x = k * delta;
		y = a(2, k+1);
		if (x + delta/2) < 3
			fprintf(f, "\\draw[line width=1pt,color=red!%d] (%.5f,%.5f)--(%.5f,%.5f);\n", 8*J + 28, x, y, x + delta, y);
		end
	end
end

fclose(f);

