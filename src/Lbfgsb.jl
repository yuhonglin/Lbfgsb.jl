module Lbfgsb

# package code goes here
macro callLBFGS(cmd)
    quote
        if length($cmd) != 0
            @simd for i = 1:length($cmd)
                task[i] = ($cmd)[i];
            end
            @simd for i = length($cmd)+1:60
                task[i] = ' ';
            end
        end

        ccall((:setulb_, "./liblbfgsb.so"),
              Void,
              (Ptr{Int32},
               Ptr{Int32},
               Ptr{Float64},
               Ptr{Float64},
               Ptr{Float64},
               Ptr{Int32},
               Ptr{Float64},
               Ptr{Float64},
               Ptr{Float64},
               Ptr{Float64},
               Ptr{Float64},
               Ptr{Int32},
               Ptr{Uint8},
               Ptr{Int32},
               Ptr{Uint8},
               Ptr{Bool},
               Ptr{Int32},
               Ptr{Float64} ),
              n,
              m,
              x,
              lb,
              ub,
              btype,
              f,
              g,
              factr,
              pgtol,
              wa,
              iwa,
              task,
              iprint,
              csave,
              lsave,
              isave,
              dsave );
    end
end

function lbfgsb (ogFunc,
                 x;
                 lb = [],
                 ub = [],
                 btype = [],
                 m::Int64 = 5,
                 maxiter::Int64 = 100,
                 factr::Float64 = 1e7,
                 pgtol::Float64 = 1e-5,
                 iprint::Int64 = -1 # does not print
                 )
    m = [convert(Int32, m)]
    factr = [convert(Float64, factr)];
    pgtol = [convert(Float64, pgtol)];
    iprint = [convert(Int32, iprint)];
    
    n = [convert(Int32, length(x))]; # number of variables
    f = [convert(Float64, 0.0)]; # The value of the objective.
    g = [convert(Float64, 0.0) for i=1:(n[1])]; # The value of the gradient.

    if length(lb) == 0
        lb = [-Inf for i=1:(n[1])];
    else
        lb = [convert(Float64, i) for i in lb]
    end

    if length(ub) == 0
        ub = [Inf for i=1:(n[1])];
    else
        ub = [convert(Float64, i) for i in ub]
    end

    if length(btype) == 0
        btype = [convert(Int32, 2) for i=1:(n[1])];
    else
        btype = [convert(Int32, i) for i in btype];
    end

    # structures used by the L-BFGS-B routine.
    wa = [convert(Float64, 0.0) for i = 1:(2*m[1] + 5)*n[1] + 12*m[1]*(m[1] + 1)];
    iwa = [convert(Int32, 0) for i = 1:3*n[1]];
    task = [convert(Uint8, 0) for i =1:60];
    csave = [convert(Uint8, 0) for i =1:60];
    lsave = [convert(Bool, 0) for i=1:4];
    isave = [convert(Int32, 0) for i=1:44];
    dsave = [convert(Float64, 0.0) for i=1:29];

    @callLBFGS "START"

    status = "success";

    t = 0;

    while true

        if task[1] == 'F'
            tf, g = ogFunc(x);
            f[1] = convert(Float64, tf);
            
        elseif task[1] == 'N'
            t += 1;
            if t >= maxiter # exceed maximum number of iteration
                @callLBFGS "STOP"
                break;
            end
        elseif task[1] == 'C' # convergence
            break;
        elseif task[1] == 'A'
            status = "abnormal";
            break;
        elseif task[1] == 'E'
            status = "error";
            break;
        end

        @callLBFGS ""
    end

    return (f, x, status, t);
end

end # module
