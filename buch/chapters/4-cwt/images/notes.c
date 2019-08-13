/*
 * notes.c
 *
 * (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <gsl/gsl_integration.h>
#include <png.h>

//static double	normierung = 2. / (sqrt(3 * sqrt(M_PI)));
static double	normierung = 0.8673250705840777;

double	psi(double t) {
	return normierung * (1 - t*t) * exp(-t*t/2);
}

double	psiab(double t, double a, double b) {
	return psi((t - b) / a) / sqrt(fabs(a));
}

double	f1(double t) {
	if (t < -3) return 0;
	if (t > -1) return 0;
	return 2 - 2 * fabs(t + 2);
}

double	f2(double t) {
	if (t < 0) return 0;
	if (t > 3) return 0;
	return 1 - cos(2 * M_PI * t);
}

double	f3(double t) {
	if (t < 4) return 0;
	if (t > 6) return 0;
	return 0.5 * (1 - cos(5 * M_PI * t));
}

double	f(double t) {
	return 2.883 * f1(t) + 1.205 * f2(t) + 2.968 * f3(t);
}

typedef struct psi_params_s {
	double	a;
	double	b;
} psi_params_t;

double	F(double t, void *params) {
	psi_params_t	*p = (psi_params_t *)params;
	return f(t) * psiab(t, p->a, p->b);
}

double	integrate(gsl_function *gf, double a, double b, size_t steps) {
	double	h = (b - a) / steps;
	double	s = 0;
	for (int i = 1; i < steps; i++) {
		double	t = a + h * i;
		s += gf->function(t, gf->params);
	}
	s += gf->function(a, gf->params);
	s += gf->function(b, gf->params);
	s *= h;
	return s;
}

static double	wmax = 0;
static const size_t	N = 400;

double	Wf(double a, double b) {
	gsl_function	gf;
	gf.function = F;
	psi_params_t	params;
	params.a = a;
	params.b = b;
	gf.params = &params;
	double	w = 0;
	w += integrate(&gf, -3, -2, N);
	w += integrate(&gf, -2, -1, N);
	w += integrate(&gf,  0,  3, N);
	w += integrate(&gf,  4,  6, N);
	if (fabs(w) > wmax) {
		wmax = fabs(w);
	}
//printf("a = %f, b = %f, w = %f, wmax = %f\n", a, b, w, wmax);
	return w;
}

static const size_t	aheight = 959;
static const size_t	bwidth = 1279;

static const double	amax = 0.6;
static const double	astep = amax / aheight;
static const double	amin = astep/2;
static const double	bmin = -4;
static const double	bmax = 7;
static const double	bstep = (bmax - bmin) / bwidth;

static double	scale = 2;

void	pixels(png_structp *png, png_infop *info) {

	png_set_IHDR(*png, *info, bwidth + 1, aheight + 1, 8,
		PNG_COLOR_TYPE_RGB,
		PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_DEFAULT,
		PNG_FILTER_TYPE_DEFAULT);
	png_write_info(*png, *info);

	png_bytep	row_pointers[aheight + 1];

	for (int ai = 0; ai <= aheight; ai++) {
		double	a = amin + ai * astep;
printf("%d %f\n", ai, a);
		row_pointers[ai] = (png_bytep)malloc(png_get_rowbytes(*png,
			*info));
		for (int bi = 0; bi <= bwidth; bi++) {
			double	b = bmin + bi * bstep;
			Wf(a, b);
		}
	}

	for (int ai = 0; ai <= aheight; ai++) {
		double	a = amin + ai * astep;
printf("%d %f\n", ai, a);
		for (int bi = 0; bi <= bwidth; bi++) {
			double	b = bmin + bi * bstep;
			int 	w = round(255 * scale * Wf(a, b) / wmax);
			if (w > 255) { w = 255; }
			if (w < -255) { w = -255; }
			if (w > 0) {
				row_pointers[aheight - ai][3 * bi + 0] = 255;
				row_pointers[aheight - ai][3 * bi + 1] = (255 - w);
				row_pointers[aheight - ai][3 * bi + 2] = (255 - w);
			} else {
				w = -w;
				row_pointers[aheight - ai][3 * bi + 0] = (255 - w);
				row_pointers[aheight - ai][3 * bi + 1] = (255 - w);
				row_pointers[aheight - ai][3 * bi + 2] = 255;
			}
		}
	}

	png_write_image(*png, row_pointers);
	png_write_end(*png, NULL);
	for (int ai = 0; ai <= aheight; ai++) {
		free(row_pointers[ai]);
	}
}

int	main(int argc, char *argv[]) {
	FILE	*outfile = fopen("notes.png", "wb");
	png_structp	png = png_create_write_struct(PNG_LIBPNG_VER_STRING,
				NULL, NULL, NULL);
	png_infop	info = png_create_info_struct(png);
	png_init_io(png, outfile);

	pixels(&png, &info);

	png_destroy_write_struct(&png, &info);

	fclose(outfile);

	return EXIT_SUCCESS;
}
