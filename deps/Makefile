SRC = ./src/Lbfgsb*/lbfgsb.f ./src/Lbfgsb*/linpack.f ./src/Lbfgsb*/timer.f ./src/Lbfgsb.3.0/blas.f

./usr/liblbfgsbf.so:
	gfortran -O3 -fPIC -shared $(SRC) -o $(OUTPUTDIR)/liblbfgsbf.so
