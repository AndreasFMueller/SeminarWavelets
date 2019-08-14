/*
 * sweep.cpp
 *
 * (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
 */
#include <png.h>
#include <cstdio>
#include <cstdlib>
#include <complex>
#include <iostream>
#include <getopt.h>

static int n = 100;

std::complex<double> gabor(double t) {
	std::complex<double> c(-t * t / 2, 5 * t);
	return exp(c);
}

double sweep(double t) {
	return sin((t + 13) * (4 + 0.2 * (t + 13)));
}

std::complex<double> W(double a, double b) {
	std::complex<double> s = 0;
	double t1 = b - 3 * a;
	double t2 = b + 3 * a;
	int N = n;
	double h = (t2 - t1) / n;
	if (h > 0.1) {
		N = n * h / 0.1;
		//std::cout << N << std::endl;
		h = (t2 - t1) / N;
	}
	s += (1 / 2) * sweep(t1) * conj(gabor((t1 - b) / a));
	for (int i = 1; i < N; i++) {
		double t = t1 + h * i;
		s += sweep(t) * conj(gabor((t - b) / a));
	}
	s += (1 / 2) * sweep(t2) * conj(gabor((t2 - b) / a));
	//std::cout << "W(" << a << ", " << b << ") = " << s << std::endl;
	return s * h / sqrt(std::abs(a));
}

template <typename T> int sgn(T val) {
	return (T(0) < val) - (val < T(0));
}

struct option options[] = {
{ "width",	required_argument,	NULL,	'w' },
{ "height",	required_argument,	NULL,	'h' },
{ "steps",	required_argument,	NULL,	'n' },
{ "output",	required_argument,	NULL,	'o' },
{ "maximum",	required_argument,	NULL,	'm' },
{ "phase",	no_argument,		NULL,	'P' },
{ "absolute",	no_argument,		NULL,	'A' },
{ "maximum",	no_argument,		NULL,	'M' },
{ NULL,		0,			NULL,	 0  }
};

typedef enum diagram_e {
	ABSOLUTE, PHASE, COLOR, SIGNED
} diagram_type;

int main(int argc, char *argv[]) {
	const char *outfilename = "sweep.png";

	int height = 1080;
	int width = 1920;

	double bmin = -10;
	double bmax = 10;
	int xmax = width;

	double amin = 0.5;
	double amax = 3;
	int ymax = height;

	int c;
	int longindex;

	diagram_type type = COLOR;

	bool show_max = false;

	double B = 1.2;

	while (EOF
			!= (c = getopt_long(argc, argv, "w:h:n:o:PAMm:", options,
					&longindex)))
		switch (c) {
		case 'w':
			width = std::stoi(optarg);
			break;
		case 'h':
			height = std::stoi(optarg);
			break;
		case 'n':
			n = std::stoi(optarg);
			break;
		case 'o':
			outfilename = optarg;
			break;
		case 'A':
			type = ABSOLUTE;
			break;
		case 'P':
			type = PHASE;
			break;
		case 'S':
			type = SIGNED;
			break;
		case 'M':
			show_max = true;
			break;
		case 'm':
			B = std::stod(optarg);
			break;
		}

	double deltab = (bmax - bmin) / (width + 1);
	double deltaa = (amax - amin) / (height + 1);

	FILE *outfile = fopen(outfilename, "wb");
	png_structp png = png_create_write_struct(PNG_LIBPNG_VER_STRING,
	NULL, NULL, NULL);
	png_infop info = png_create_info_struct(png);
	png_init_io(png, outfile);

	png_set_IHDR(png, info, xmax + 1, ymax + 1, 8,
	PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
	PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
	png_write_info(png, info);

	png_bytep row_pointers[ymax + 1];
	for (int yi = 0; yi <= ymax; yi++) {
		row_pointers[yi] = (png_bytep) malloc(png_get_rowbytes(png, info));
	}

	std::cout << "dimensions: width=" << xmax << ", height=" << ymax
			<< std::endl;

	double A = 0;
	for (int x = 0; x <= xmax; x++) {
		double b = bmin + x * deltab;
		double maxvalue = 0;
		int maxindex = -1;
		for (int y = ymax; y >= 0; y--) {
			double a = amin + y * deltaa;
			std::complex<double> c = W(1 / a, b);
			double	s = sgn(c.real());
			if (abs(c) > A) {
				A = abs(c);
			}
			if ((abs(c) > maxvalue) && (y >= 100)) {
				maxvalue = abs(c);
				maxindex = y;
			}
			c = c / B;
			unsigned char w = trunc(abs(c) * 256);
			double phi = arg(c);
			switch (type) {
			case COLOR:
				//w = 64 + 0.75 * w;
				row_pointers[ymax - y][3 * x + 0] = round(
						abs(w * (1 + cos(phi)) / 2));
				phi += 2 * M_PI / 3;
				row_pointers[ymax - y][3 * x + 1] = round(
						abs(w * (1 + cos(phi)) / 2));
				phi += 2 * M_PI / 3;
				row_pointers[ymax - y][3 * x + 2] = round(
						abs(w * (1 + cos(phi)) / 2));
				break;
			case ABSOLUTE:
				row_pointers[ymax - y][3 * x + 0] = 255;
				row_pointers[ymax - y][3 * x + 1] = 255 - w;
				row_pointers[ymax - y][3 * x + 2] = 255 - w;
				break;
			case PHASE:
				w = trunc(256 * (phi / (2 * M_PI)));
				row_pointers[ymax - y][3 * x + 0] = 255 - w;
				row_pointers[ymax - y][3 * x + 1] = 255 - w;
				row_pointers[ymax - y][3 * x + 2] = 255;
				break;
			case SIGNED:
				if (s > 0) {
				row_pointers[ymax - y][3 * x + 0] = 255;
				row_pointers[ymax - y][3 * x + 1] = 255 - w;
				row_pointers[ymax - y][3 * x + 2] = 255 - w;
				} else {
				row_pointers[ymax - y][3 * x + 0] = 255 - w;
				row_pointers[ymax - y][3 * x + 1] = 255 - w;
				row_pointers[ymax - y][3 * x + 2] = 255;
				}
				break;
			}
		}
		if ((show_max) && (maxindex > 0) && (maxindex < ymax)) {
			int j = ymax - maxindex;
			switch (type) {
			case COLOR:
				row_pointers[j - 1][3 * x + 0] = 255;
				row_pointers[j - 1][3 * x + 1] = 255;
				row_pointers[j - 1][3 * x + 2] = 255;
				row_pointers[j    ][3 * x + 0] = 255;
				row_pointers[j    ][3 * x + 1] = 255;
				row_pointers[j    ][3 * x + 2] = 255;
				row_pointers[j + 1][3 * x + 0] = 255;
				row_pointers[j + 1][3 * x + 1] = 255;
				row_pointers[j + 1][3 * x + 2] = 255;
				break;
			case ABSOLUTE:
			case SIGNED:
				row_pointers[j - 1][3 * x + 0] = 0;
				row_pointers[j - 1][3 * x + 1] = 154;
				row_pointers[j - 1][3 * x + 2] = 0;
				row_pointers[j    ][3 * x + 0] = 0;
				row_pointers[j    ][3 * x + 1] = 154;
				row_pointers[j    ][3 * x + 2] = 0;
				row_pointers[j + 1][3 * x + 0] = 0;
				row_pointers[j + 1][3 * x + 1] = 154;
				row_pointers[j + 1][3 * x + 2] = 0;
				break;
			case PHASE:
				row_pointers[j - 1][3 * x + 0] = 0;
				row_pointers[j - 1][3 * x + 1] = 154;
				row_pointers[j - 1][3 * x + 2] = 0;
				row_pointers[j    ][3 * x + 0] = 0;
				row_pointers[j    ][3 * x + 1] = 154;
				row_pointers[j    ][3 * x + 2] = 0;
				row_pointers[j + 1][3 * x + 0] = 0;
				row_pointers[j + 1][3 * x + 1] = 154;
				row_pointers[j + 1][3 * x + 2] = 0;
				break;
			}
		}

		std::cout << ".";
		std::cout.flush();
	}
	std::cout << "absolute value: " << A << std::endl;

	png_write_image(png, row_pointers);
	png_write_end(png, NULL);

	for (int yi = 0; yi <= ymax; yi++) {
		free(row_pointers[yi]);
	}

	png_destroy_write_struct(&png, &info);

	fclose(outfile);

	return EXIT_SUCCESS;
}
