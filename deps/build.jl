# it seems that we need to write the "deps.jl" ourselves

using BinDeps

@BinDeps.setup

lbfgsbf = library_dependency("lbfgsbf", aliases=["liblbfgsbf"])

function mklibdir()
    depdir = BinDeps.depsdir(lbfgsbf);
    usrdir = joinpath(depdir, "usr");
    
    if isdir(usrdir) == false
        mkdir(usrdir);
    end

    usrdir = joinpath(depdir, "lib");
    if isdir(usrdir) == false
        mkdir(usrdir);
    end
end

function runmake()
    usrdir = joinpath(BinDeps.depsdir(lbfgsbf), "usr", "lib");
    run(`make OUTPUTDIR=$(usrdir)`)
end


function writeDeps()
    prefix = joinpath(BinDeps.depsdir(lbfgsbf))
    libpath = joinpath(prefix, "usr", "lib", "liblbfgsbf.so")
    outputfile = open(joinpath(prefix, "deps.jl"), "w");
    write( outputfile, "macro checked_lib(libname, path)\n    (dlopen_e(path) == C_NULL) && error(\"Unable to load \\n\\n\$libname (\$path)\n\nPlease re-run Pkg.build(package), and restart Julia.\")\n    quote const \$(esc(libname)) = \$path end\nend\n@checked_lib liblbfgsbf \"$(libpath)\"\n")
end

provides(Sources, { URI("http://users.iems.northwestern.edu/~nocedal/Software/Lbfgsb.3.0.tar.gz") => lbfgsbf });


provides(SimpleBuild,
         (@build_steps begin
             GetSources(lbfgsbf)
             mklibdir()
             runmake()
          end), lbfgsbf)

writeDeps()
         
@BinDeps.install
