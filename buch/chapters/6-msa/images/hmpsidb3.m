#
#

global h;
h = [  0.6830127,  1.1830127, 0.3169873, -0.1830127 ];
global g;
g = [ -0.1830127, -0.3169873, 1.1830127, -0.6830127 ];

#h = [ 1, 1 ];

function retval = H(s) 
	global h
	retval = 0;
	n = size(h)(2);
	for k = (0:n-1)
		retval = retval + h(1,k+1) * exp(I * k * s);
	end
	retval = retval / sqrt(2);
end

function retval = mpsi(s)
	global g
	retval = 0;
	n = size(g)(2);
	for k = (0:n-1)
		retval = retval + g(1,k+1) * exp(I * k * s);
	end
	retval = retval / sqrt(2);
end

N = 100;
deltaomega = 2 * pi / N;

h = [
	0.47046721, 1.14111692, 0.650365, -0.19093442, -0.12083221, 0.0498175
];

h = [
	0.32580343, 1.01094572, 0.8922014, -0.03967503, -0.26450717, 0.0436163, 0.0465036, -0.01498699
]

h = [
	0.22641898, 0.85394354, 1.02432694, 0.19576696, -0.34265671, -0.04560113, 0.10970265, -0.00882680, -0.01779187, 0.00471742793
];

h = [
	0.15774243, 0.69950381, 1.06226376, 0.44583132, -0.31998660, -0.18351806, 0.13788809, 0.03892321, -0.04466375, 0.000783251152, 0.00675606236, -0.00152353381
];

sum(h)

n = size(h)(2);
g = zeros(1, n);
for k = 1:n
	g(1,k) = (-1)^k * h(n+1-k);
end

f = fopen("hmpsipath.tex", "w");
fprintf(f, "\\draw[color=blue,line width=1pt]\n");
fprintf(f, "\t(0,%.3f)\n", abs(H(0))^2);
for j = (1:N)
	omega = j * deltaomega;
	fprintf(f, "\t--(%.3f,%.3f)\n", 2*omega, abs(H(omega))^2);
end
fprintf(f, ";\n");
fprintf(f, "\\draw[color=red,line width=1pt]\n");
fprintf(f, "\t(0,%.3f)\n", abs(mpsi(0))^2);
for j = (1:N)
	omega = j * deltaomega;
	fprintf(f, "\t--(%.3f,%.3f)\n", 2*omega, abs(mpsi(omega))^2);
end
fprintf(f, ";\n");
fclose(f);

