/*
 * B.c -- computation of coefficients for phi_n
 *
 * (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
 */
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <math.h>

static int	debug = 0;
int	degree = 1;
int	K = 100;
int	N = 1024;

static struct option	longopts[] = {
{ "debug",	no_argument,		NULL,		'd' },
{ "degree",	required_argument,	NULL,		'n' },
{ "size",	required_argument,	NULL,		'N' },
{ NULL,		0,			NULL,		 0  }
};

inline double	sqr(double x) { return x * x; }

double	sinc(double omega) {
	if (omega == 0) {
		return 1;
	}
	return sin(omega) / omega;
}

double	FBn(double omega, int n) {
	return 0;
}

double	Phin(double omega, int n) {
	if (0 == omega) {
		return 1;
	}
	double	s = 0;
	for (int l = -K; l <= K; l++) {
		s += pow(1 / (omega / 2 + M_PI * l), 2*n+2);
	}
	return pow(sin(omega/2), 2*n + 2) * s;
}

int	main(int argc, char *argv[]) {
	int	c;
	int	longindex;
	while (EOF != (c = getopt_long(argc, argv, "d", longopts, &longindex)))
		switch (c) {
		case 'd':
			debug = 1;
			break;
		case 'n':
			degree = atoi(optarg);
			break;
		case 'N':
			N = atoi(optarg);
			break;
		}
	
	// read command line arguments

	// prepare array for phi values
	double	*PhiNp = (double *)calloc(2*N+1, sizeof(double));
	for (int i = -N; i <= N; i++) {
		double	omega = M_PI * i / N;
		if (i == 0) {
			PhiNp[i + N] = 1;
		} else {
			PhiNp[i + N] = Phin(omega, degree);
		}
	}
	for (int i = -5; i <= 5; i++) {
		printf("Phi_%d[%02d] = %f\n", degree, i, PhiNp[i + N]);
	}

	// compute the cosine coefficients
	double	*cp = (double *)calloc(2*K+1, sizeof(double));
	for (int k = -K; k <= K; k++) {
		fprintf(stderr, "computing c_{%d}\n", k);
		double	s = 0;
		s = 0.5 * cos(k * M_PI) / sqrt(PhiNp[0]);
		for (int l = -N+1; l < N; l++) {
			double	omega = M_PI * l / N;
			double	p = PhiNp[l + N];
			s += cos(k * omega) / sqrt(p);
		}
		s += sqrt(PhiNp[2*N]) / 2;
		cp[k + K] = s / (2 * M_PI);
		cp[k + K] *= M_PI / N;
	}
	fprintf(stderr, "fourier coefficients computed\n");
	for (int k = -10; k <= 31; k++) {
		printf("c[%3d] = %f\n", k, cp[k+K]);
	}
}
 
