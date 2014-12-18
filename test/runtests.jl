using Lbfgsb
using Base.Test


function ogFunc!(x, g::Vector)

    f = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2;

    g[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1];
    g[2] = 200.0 * (x[2] - x[1]^2);

    return f;
end

x = [0.0 0.0];

f, x, numCall, numIter, status  = lbfgsb( ogFunc!, x, iprint=-1 )

@test abs(f) < 0.00001
@test abs(x[1]-1) < 0.00001
@test abs(x[2]-1) < 0.00001


function objFunc(x)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

function gradFunc!(x, g::Vector)
    g[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1];
    g[2] = 200.0 * (x[2] - x[1]^2);
    return
end

x = [0.0 0.0];

f, x, numCall, numIter, status  = lbfgsb( objFunc, gradFunc!, x, iprint=-1 )

@test abs(f) < 0.00001
@test abs(x[1]-1) < 0.00001
@test abs(x[2]-1) < 0.00001

# write your own tests here
@test 1 == 1
