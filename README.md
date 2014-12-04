# Lbfgsb.jl

This is wrapper of the famous [lbfgsb fortran library] of Julia language inspired by [this wrapper]

## version
0.0.1 (just usable...)

## Copyright Notice
  File ```solver.f``` is written by the authors of the following papers,
  - R. H. Byrd, P. Lu and J. Nocedal. A Limited Memory Algorithm for Bound Constrained Optimization, (1995), SIAM Journal on Scientific and Statistical Computing , 16, 5, pp. 1190-1208.
  - C. Zhu, R. H. Byrd and J. Nocedal. L-BFGS-B: Algorithm 778: L-BFGS-B, FORTRAN routines for large scale bound constrained optimization (1997), ACM Transactions on Mathematical Software, Vol 23, Num. 4, pp. 550 - 560.
  - J.L. Morales and J. Nocedal. L-BFGS-B: Remark on Algorithm 778: L-BFGS-B, FORTRAN routines for large scale bound constrained optimization (2011), to appear in ACM Transactions on Mathematical Software.

## Warning
I am new to Julia language so the code will be cleaned gradually

## usage
  - first run ```make```
  - see test.jl for example

License
----
BSD-3

[lbfgsb fortran library]:http://users.iems.northwestern.edu/~nocedal/lbfgsb.html
[this wrapper]:http://hannes.nickisch.org/code/glm-ie/pls/lbfgsb/README.html
