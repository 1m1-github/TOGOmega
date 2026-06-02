module TOGOmega

const T = Float32
export T

using Pkg, RemoteREPL
using TOG: 𝕋, t
using TOGZMQServer, TOGCommunicationServer

const Ω = 𝕋()

# function awaken(gods)
function awaken(;router::String, pub::String, tog::String, replport::Integer)
    # Pkg.update()
    # write(joinpath(".tog", "pid"), getpid())
    @async serve_repl(replport)
    TOGZMQServer.awaken(router=router,pub=pub,tog=tog, ω=Ω)
    TOGCommunicationServer.awaken(router=router, pub=pub)
    # [TOGInstall.awakengod(name=god, router=ROUTERLOCATION, pub=PUBLOCATION, tog=TOGLOCATION, replport=TOGInstall.openport()) for god = gods]
    # TOGREPL.awaken(true)
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

# function (@main)(ARGS)
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
