#
# Winverse.m -- Wavelet synthesis from coefficients
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#

function Winverse(filename, a, b, h, J, farbe)
	l = size(h)(2);
	g = zeros(1,l);
	for i = (1:l)
		g(1,i) = h(1,l+1-i) * (-1)^i;
	end
	N = l * 2^J;
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

function Wphi(filename, h, J, farbe)
	l = size(h)(2);
	N = l * 2^J;
	a = zeros(2, N);
	b = zeros(2, N);
	a(1,1) = 1;
	Winverse(filename, a, b, h, J, farbe);
end

function Wpsi(filename, h, J, farbe)
	l = size(h)(2);
	N = l * 2^J;
	a = zeros(2, N);
	b = zeros(2, N);
	b(1,1) = 1;
	Winverse(filename, a, b, h, J, farbe);
end

