module TOGOmega

const T = Float32
export T

using Pkg, RemoteREPL, ArgParse, Serialization
using TOG: 𝕋, t
using TOGZMQServer, TOGCommunicationServer, TOGAwaken

const Ωpath = joinpath(TOGAwaken.TOGDIR, "Ω")
const Ω = isfile(Ωpath) ? deserialize(Ωpath) : 𝕋()

# function __init__()
#     isfile(joinpath(DEPOT_PATH[1], "registries", "General.toml")) || Pkg.Registry.add("General")
#     isfile(joinpath(DEPOT_PATH[1], "registries", "$(TOGLearning.REGISTRYNAME)", "Registry.toml")) || Pkg.Registry.add(url="$REGISTRYURL")
# end

function awaken(; router=TOGAwaken.router(), pub=TOGAwaken.pub(), tog=TOGAwaken.tog(), replport=TOGAwaken.openport())
    @show replport, getpid()
    TOGAwaken.isrunning() && error("TOGOmega is already running.")
    TOGAwaken.writepid()
    @async serve_repl(replport)
    TOGZMQServer.awaken(router=router, pub=pub, tog=tog, ω=Ω)
    TOGCommunicationServer.awaken(router=router, pub=pub)
    @show "TOGOmega.jl is awake."
    # [TOGInstall.awakengod(name=god, router=ROUTERLOCATION, pub=PUBLOCATION, tog=TOGLOCATION, replport=TOGInstall.openport()) for god = gods]
    # TOGREPL.awaken(true)
end
function atexit()
    serialize(Ωpath, Ω)
    TOGAwaken.rmpid()
end

# function parse_commandline()
#     s = ArgParseSettings()
#     @add_arg_table s begin
#         "--init"
#         action = :store_true
#         "--update"
#         action = :store_true
#         "path"
#         arg_type = String
#         default = "."
#     end
#     return parse_args(s)
# end

# function (@main)(args)
    # #     # Pkg.update()
    # #     # manifest = joinpath(dirname(Pkg.project().path), "Manifest.toml")
    # #     # prehash = hash(read(manifest))
    # #     # Pkg.update()
    # #     # posthash = hash(read(manifest))
    # #     # updated = prehash != posthash
    # #     # if updated
    # #     #     run(`tog `)
    # #     #     exit(0)
    # #     # end
    # #     # DEPOT_PATH[1]=joinpath(pwd(),".loopos")
    #     config = parse_commandline()
    #     if config["init"]

    #     end
    #     if config["update"]
    #         Pkg.update()
    #         # Pkg.Apps.update("tog")
    #         return
    #     end
    #     awaken(path=ARGS[1])
    # #     TOGInstall.awaken()
# end

end
