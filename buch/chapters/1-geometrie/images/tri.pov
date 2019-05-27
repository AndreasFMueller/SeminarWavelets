//
// tri.pov -- 
//
// (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
//
#version 3.7;
#include "colors.inc"
#include "../../../common/common.inc"

global_settings {
        assumed_gamma 1
}

#declare imagescale = 0.24;

camera {
        location <15, 8.3, 3>
        look_at <0, 0, 0>
        right 16/9 * x * imagescale
        up y * imagescale
}

light_source {
        <30, 40, -5> color White
        area_light <0.1,0,0> <0,0,0.1>, 10, 10
        adaptive 1
        jitter
}

sky_sphere {
        pigment {
                color rgb<1,1,1>
        }
}

#declare N = <1,1,1>;
#declare n = vnormalize(N);

#declare e1 = <1,0,0>;
#declare e3 = <0,1,0>;
#declare e2 = <0,0,1>;

#declare b1 = <1,-0.5,-0.5>;
#declare b2 = <-0.5,-0.5,1>;
#declare b3 = <-0.5,1,-0.5>;

#declare B1 = vnormalize(b1);
#declare B2 = vnormalize(b2);
#declare B3 = vnormalize(b3);

#declare E1 = B1;
#declare E2 = vnormalize(B2 + 0.5*B1);

#declare boxsize = 1.5;
#declare gridsize = 3;

arrow(-(boxsize + 0.3) * e1, (boxsize + 0.3) * e1, 0.02, White)
arrow(-(boxsize + 0.3) * e2, (boxsize + 0.3) * e2, 0.02, White)
arrow(-(boxsize + 0.3) * e3, (boxsize + 0.3) * e3, 0.02, White)

arrow(<0,0,0>, b1, 0.03, Red)
arrow(<0,0,0>, b2, 0.03, Red)
arrow(<0,0,0>, b3, 0.03, Red)

arrow(<0,0,0>, n, 0.02, Green)

arrow(<0,0,0>, E1, 0.04, Blue)
arrow(<0,0,0>, E2, 0.04, Blue)

//
// Koordinatensystem
//
#ifndef (show_2dgrid) #declare show_2dgrid = false; #end
#if (show_2dgrid)
intersection {
	box { -boxsize*N, boxsize*N }
	union {
	#declare i = -gridsize;
	#while (i <= gridsize)
		cylinder {
			i * E1 - gridsize * E2, i * E1 + gridsize * E2, 0.01
		}
		cylinder {
			i * E2 - gridsize * E1, i * E2 + gridsize * E1, 0.01
		}
		#declare i = i + 1;
	#end
	}
	pigment {
		color Blue
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

intersection {
	box { -boxsize*N, boxsize*N }
	union {
		cylinder { -gridsize * E2, gridsize * E2, 0.0101 }
		cylinder { -gridsize * E1, gridsize * E1, 0.0101 }
	}
	pigment {
		color Blue
	}
	finish {
		specular 0.9
		metallic
	}
}

#ifndef (show_trigrid) #declare show_trigrid = true; #end
#if (show_trigrid)
intersection {
	box { -boxsize*N, boxsize*N }
	union {
	#declare i = -gridsize;
	#while (i <= gridsize)
		cylinder {
			i * b1 - gridsize * b2, i * b1 + gridsize * b2, 0.01
		}
		cylinder {
			i * b2 - gridsize * b3, i * b2 + gridsize * b3, 0.01
		}
		cylinder {
			i * b3 - gridsize * b1, i * b3 + gridsize * b1, 0.01
		}
		#declare i = i + 1;
	#end
	}
	pigment {
		color Red
	}
	finish {
		specular 0.9
		metallic
	}
}
#end

intersection {
	plane { N, 0.001 }
	plane { -N, -0.001 }
	box { -boxsize*<1,1,1>, boxsize*<1,1,1> }
	pigment {
		color rgbf<0.8,0.8,1,0.7>
	}
	finish {
		specular 0.9
		metallic
	}
}

#declare V = 0.9 * B1 + 0.8 * B2;
#declare Vprime = (2/3) * (vdot(V, B1) * B1 + vdot(V, B2) * B2 + vdot(V, B3) * B3);
#declare Vx = E1 * vdot(Vprime, E1);
#declare Vy = E2 * vdot(Vprime, E2);

union {
	#declare of = -5;
	#while (of <= 5)
		#declare V = Vprime + 0.3 * of * n;
		intersection {
			box { -boxsize*<1,1,1>, boxsize*<1,1,1> }
			sphere { V, 0.03 }
		}
		#declare of = of + 1;
	#end
	intersection {
		box { -boxsize*<1,1,1>, boxsize*<1,1,1> }
		cylinder { Vprime + 10 * n, Vprime - 10 * n, 0.01 }
	}
	cylinder { Vx, Vprime, 0.01 }
	cylinder { Vy, Vprime, 0.01 }
	sphere { Vprime, 0.04 }
	pigment {
		color Yellow
	}
	finish {
		specular 0.9
		metallic
	}
}

intersection {
	plane { n, 0 }
	box { -boxsize * N, boxsize * N }
	pigment {
		color rgbf<0.8,0.8,0.8,0.9>
	}
	finish {
		specular 0.9
		metallic
	}
}


