liblbfgsb.so: solver.f Makefile
	gfortran -fPIC -shared -O3 ./solver.f -o liblbfgsb.so
