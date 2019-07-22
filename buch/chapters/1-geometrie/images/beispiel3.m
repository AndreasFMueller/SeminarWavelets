#
# beispiel3.m
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#

global N;
N = 100;
l = 10;
c = (l+1)/2;

global w;
w = 13;

global s;
s = 2;

global T;
T = zeros(N + l - 1, N);

for i = (1:N+l-1)
	for j = (1:N)
		if ((j <= i) && ((i - l + 1) <= j))
			T(i,j) = 1;
		else
			T(i,j) = 0;
		end
#		T(i,j) = exp(-(i - j)^2 / 9);
#		if (abs(i-c-j+1) > c)
#			T(i,j) = 0;
#		else
#			T(i,j) = c - abs(i-c-j+1);
#		end
	end
	T(i,:) = T(i,:) / norm(T(i,:));
end

T;

G = T' * T;

global S;
S = inverse(G) * T';

e = eig(G);

max(e)
min(e)

global f;
f = fopen("b3curves.tex", "w");

function retval = bcurve(name, i)
	global f;
	global T;
	global N;
	global w;
	global s;
	fprintf(f, "\\def\\%s{\n", name);
	fprintf(f, "\\draw[color=red,line width=1pt] (0,%.4f)\n", s*T(i,1));
	for j = (2:N) 
		fprintf(f, "--(%.4f,%.4f)\n", w*(j-1)/(N-1), s*T(i,j));
	end
	fprintf(f, ";}\n");
	retval = 0;
endfunction

function retval = btildecurve(name, i)
	global f;
	global S;
	global N;
	global w;
	global s;
	fprintf(f, "\\def\\%s{\n", name);
	fprintf(f, "\\draw[color=blue,line width=1pt] (0,%.4f)\n", s*S(1,i));
	for j = (2:N) 
		fprintf(f, "--(%.4f,%.4f)\n", w*(j-1)/(N-1), s*S(j,i));
	end
	fprintf(f, ";}\n");
	retval = 0;
endfunction

examples = [1, 3, 6, 10, 20, 30, 40, 50, 60, 70];


bcurve("curveone",   examples( 1));
bcurve("curvetwo",   examples( 2));
bcurve("curvethree", examples( 3));
bcurve("curvefour",  examples( 4));
bcurve("curvefive",  examples( 5));
bcurve("curvesix",   examples( 6));
bcurve("curveseven", examples( 7));
bcurve("curveeight", examples( 8));
bcurve("curvenine",  examples( 9));
bcurve("curveten",   examples(10));

btildecurve("dualcurveone",   examples( 1));
btildecurve("dualcurvetwo",   examples( 2));
btildecurve("dualcurvethree", examples( 3));
btildecurve("dualcurvefour",  examples( 4));
btildecurve("dualcurvefive",  examples( 5));
btildecurve("dualcurvesix",   examples( 6));
btildecurve("dualcurveseven", examples( 7));
btildecurve("dualcurveeight", examples( 8));
btildecurve("dualcurvenine",  examples( 9));
btildecurve("dualcurveten",   examples(10));

fclose(f);

