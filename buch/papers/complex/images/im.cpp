/*
 * im.cpp
 *
 * (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
 * (c) 2019 Roy Seitz, Hochschule Rapperswil
 */
#include <png.h>
#include <math.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <getopt.h>

using namespace std;

struct option options[] = { { "width", required_argument, NULL, 'w' }, {
		"height", required_argument, NULL, 'h' }, { "steps", required_argument,
NULL, 'n' }, { "output", required_argument, NULL, 'o' }, { "maximum",
required_argument, NULL, 'm' }, { "phase", no_argument, NULL, 'P' }, {
		"absolute", no_argument, NULL, 'A' }, { "maximum", no_argument, NULL,
		'M' }, { NULL, 0, NULL, 0 } };

int ang2blue(double phi, double mag){
	// Blue is a even function
	phi *= 180.0 / M_PI;
	int ang = round(phi);
	ang = abs((ang + 180) % 360 - 180);

	if (ang <= 60){ // Fully on
		return round(mag);
	} else if (ang < 120) { // Linearly falling
		return round(mag * (240.0 - 2.0 * ang) / 120.0);
	} else // Fully off
		return 0;
}

int hue2rgb(png_bytep res, double phi, double mag){
	res[0] = ang2blue(phi + M_PI * 2 / 3, mag); // Red
	res[1] = ang2blue(phi + M_PI * 4 / 3, mag); // Green
	res[2] = ang2blue(phi + 0.0  , mag); // Blue
	return 0;
}


int main(int argc, char *argv[]) {
	const char *infilename = "im.dat";
	const char *outfilename = "im.png";

	int height = 0;
	int width = 0;

	bool show_max = true;
	int c;
	int longindex;

	while (EOF != (c = getopt_long(argc, argv, "i:o:M", options, &longindex)))
		switch (c) {
		case 'i':
			infilename = optarg;
			break;
		case 'o':
			outfilename = optarg;
			break;
		case 'M':
			// show_max = false; // Use show_max in octave!
			break;
		}

	// Read in imag data from infile
	FILE *infile = fopen(infilename, "r");
	if (infile == 0) {
		cerr << "Error: could not open " << infilename << "!" << endl;
		return 1;
	}

	double wi, hi;
	if (fscanf(infile, "%lf %lf\n", &wi, &hi) != 2) {
		cerr << "Error: could not read width and height from " << infilename
				<< "!" << endl;
		fclose(infile);
		return 1;
	}

	width = wi;
	height = hi;
	cout << "dimensions: width=" << width << ", height=" << height << endl;

	// Open output file
	FILE *outfile = fopen(outfilename, "wb");
	png_structp png = png_create_write_struct(PNG_LIBPNG_VER_STRING,
	NULL, NULL, NULL);
	png_infop info = png_create_info_struct(png);
	png_init_io(png, outfile);

	png_set_IHDR(png, info, width, height, 8,
	PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
	PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
	png_write_info(png, info);

	png_bytep row_pointers[height];
	for (int yi = 0; yi < height; yi++)
		row_pointers[yi] = (png_bytep) malloc(png_get_rowbytes(png, info));

	// Read data and write to png
	double **mag = (double**) malloc(sizeof(double*) * height);
	double **phi = (double**) malloc(sizeof(double*) * height);

	double m;
	double p;

	cout << "Reading file " << infilename << " ..." << endl;
	for (int y = 1; y <= height; y++) {
		mag[y] = (double*) malloc(sizeof(double) * width);
		phi[y] = (double*) malloc(sizeof(double) * width);
		for (int x = 0; x < width; x++) {
			fscanf(infile, "%lf %lf, ", &m, &p);
			mag[y][x] = m;
			phi[y][x] = p;
		}
	}
	fclose(infile);

	cout << "Converting mag:ang to color..." << endl;
	for (int y = 1; y <= height; y++) {
		for (int x = 0; x < width; x++) {
			m = mag[y][x];
			if ((m == 255) & show_max){
				row_pointers[height - y][3 * x + 0] = 255;
				row_pointers[height - y][3 * x + 1] = 255;
				row_pointers[height - y][3 * x + 2] = 255;
			} else {
				hue2rgb(&row_pointers[height - y][3 * x], phi[y][x], m);
			}
		}
	}

	cout << "Saving png..." << endl;

	png_write_image(png, row_pointers);
	png_write_end(png, NULL);

	for (int yi = 0; yi < height; yi++) {
		free(row_pointers[yi]);
	}

	png_destroy_write_struct(&png, &info);

	fclose(outfile);

	cout << "Done!" << endl << endl;
	return EXIT_SUCCESS;
}
