#
# notes.m
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
amax = 0.4;
astep = amax / 100;
amin = astep / 2;

bstep = 0.1;
bmin = -4 + bstep/2;
bmax = 7 - bstep/2;

global a;
global b;

function retval = f(t)
	if (t < -3)
		retval = 0;
	elseif (t < -2)
		retval = 2.883 * (6 + 2 * t);
	elseif (t < -1)
		retval = 2.883 * (-2 - 2 * t);
	elseif (t < 0)
		retval = 0;
	elseif (t < 3)
		retval = .1205 * (1 - cos(2 * pi * t));
	elseif (t < 4)
		retval = 0;
	elseif (t < 6)
		retval = 0.968 * (0.5 * (1 - cos(5 * pi * t)));
	else
		retval = 0;
	endif
endfunction

function retval = psi(t)
	retval = 2 * (1 - t^2) * exp(-t^2/2) / (sqrt(3) * pi^(1/4));
endfunction

function retval = psiab(t)
	global a
	global b
	retval = (1 / sqrt(abs(a))) * psi((t - b)/a);
endfunction

function gdot = g(x, t)
	gdot = zeros(1,1);
	gdot(1) = f(t) * psiab(t);
endfunction

function retval = Wf()
	global a
	global b
	x0 = zeros(1);
	t0 = -3;
	t1 = 6;
	y = lsode("g", x0, [t0, t1]);
	retval = y(2);
endfunction

wmax = 0;
wnorm = 0.84605;

f = fopen("notesdots.tex", "w");
for a = (amin:astep:amax)
	printf("a = %f\n", a);
	for b = (bmin:bstep:bmax)
		w = abs(Wf());
		if (w > wmax)
			wmax = w
		endif
		w = round(100 * w / wnorm);
		fprintf(f, "%% a=%.3f b=%.3f\n", a, b);
		fprintf(f, "\\punkt{%.3f}{%.3f}{%.0f}\n", 10 * a / amax, b, w)
	endfor
endfor
fclose(f);

wmax
