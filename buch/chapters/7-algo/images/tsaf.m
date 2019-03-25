#
# tsaf.m -- fast synthesis
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
l = 4;
J = 9;
N = l * 2^J;

global l
global J
global N

global h
global g

function wavelet(name, a, b, farbe)
	global	h
	global	g
	global	l
	global	J
	global	N
	for j = (1:J)
		delta = 2^(-j);
		for i = (0:2:N-1)
			# berechne a(j+1,i)
			s = 0;
			for k = (0:2:l-1)
				hkoef = h(1,k + 1);
				gkoef = g(1,k + 1);
				aindex = i/2 - k/2;
				if (aindex >= 0) and (aindex < N)
					s = s + hkoef * a(1, aindex + 1);
					s = s + gkoef * b(1, aindex + 1);
				end
			end
			a(2, i+1) = s;
			# berechne a(j+1,i+1)
			s = 0;
			for k = (1:2:l-1)
				hkoef = h(1,k + 1);
				gkoef = g(1,k + 1);
				aindex = i/2 - (k-1)/2;
				if (aindex >= 0) and (aindex < N)
					s = s + hkoef * a(1, aindex + 1);
					s = s + gkoef * b(1, aindex + 1);
				end
			end
			a(2, i+2) = s;
		end

		b(1,:) = zeros(1, N);
		a(1,:) = a(2,:);
	end

	filename = sprintf("%s", name);
printf("filename: %s\n", filename);
	f = fopen(filename, "w");
	fprintf(f, "\\draw[line width=1pt,color=%s] ", farbe);
	top = (l - 1) * 2^J;
	for i = (0:top-1)
		if (i > 1)
			fprintf(f, "--");
		end
		fprintf(f, "(%.5f, %.5f)\n", i * delta, a(1, i+1));
	end
	fprintf(f, ";\n");
	fclose(f);
end

# db1

l = 2;
J = 9;
N = l * 2^J;

h = [ 1,  1 ]
g = [ 1, -1 ]

a = zeros(2, N);
b = zeros(2, N);
a(1,1) = 1;

wavelet("phi-db1.tex", a, b, "blue");

a = zeros(2, N);
b = zeros(2, N);
b(1,1) = 1;

wavelet("psi-db1.tex", a, b, "red");

# db2

l = 4;
J = 9;
N = l * 2^J;

h = [ 0.6830127, 1.1830127, 0.3169873, -0.1830127 ];
g = [ 0.1830127, -0.3169873, 1.1830127, -0.6830127 ];

a = zeros(2, N);
b = zeros(2, N);
a(1,1) = 1;

wavelet("phi-db2.tex", a, b, "blue");

a = zeros(2, N);
b = zeros(2, N);
b(1,1) = 1;

wavelet("psi-db2.tex", a, b, "red");

# db3

l = 6;
J = 9;
N = l * 2^J;

h = [ 0.47046721, 1.14111692, 0.650365, -0.19093442, -0.12083221, 0.0498175 ];
g = [ 0.0498175, +0.12083221, -0.19093442, -0.650365, 1.14111692, -0.47046721 ];

a = zeros(2, N);
b = zeros(2, N);
a(1,1) = 1;

wavelet("phi-db3.tex", a, b, "blue");

a = zeros(2, N);
b = zeros(2, N);
b(1,1) = 1;

wavelet("psi-db3.tex", a, b, "red");

# db4

l = 8;
J = 9;
N = l * 2^J;

h = [ 0.32580343, 1.01094572, 0.8922014, -0.03967503, -0.26450717, 0.0436163, 0.0465036, -0.01498699 ]
g = [ -0.01498699, -0.0465036, 0.0436163, 0.26450717, -0.03967503, -0.8922014, 1.01094572, -0.32580343 ]

a = zeros(2, N);
b = zeros(2, N);
a(1,1) = 1;

wavelet("phi-db4.tex", a, b, "blue");

a = zeros(2, N);
b = zeros(2, N);
b(1,1) = 1;

wavelet("psi-db4.tex", a, b, "red");

