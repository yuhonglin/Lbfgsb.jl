include ("Lbfgsb.jl")


function ogFunc(x)

    f = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
    g = [0.0 0.0]

    g[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1]
    g[2] = 200.0 * (x[2] - x[1]^2)

    return (f,g)
end

x = [0.0 0.0];

f, x, status, numIter  = lbfgsb( ogFunc, x, iprint=1 )

print ("optimal value : $f\n")
print ("optimal x     : $x\n")
print ("status        : $status\n")
print ("number of Iteration : $numIter\n")
