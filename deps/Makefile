SRC = ./Lbfgsb*/lbfgsb.f ./Lbfgsb*/linpack.f ./Lbfgsb*/timer.f ./Lbfgsb*/blas.f

./usr/liblbfgsbf.so:
	gfortran -O3 -fPIC -shared $(SRC) -o $(OUTPUTDIR)/liblbfgsbf.so
