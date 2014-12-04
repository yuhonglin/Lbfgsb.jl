liblbfgsb.so: solver.f Makefile
	gfortran -fPIC -shared ./solver.f -o liblbfgsb.so
