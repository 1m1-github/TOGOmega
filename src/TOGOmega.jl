module TOGOmega

const T = Float32
export T

using Pkg
using TOG: 𝕋, t
using TOGZMQServer, TOGREPL, TOGCommunicationServer, TOGInstall

const Ω = 𝕋()

const ROUTERLOCATION = "ipc://$(pwd())/router.ipc" # change to tcp if on separate machines
const PUBLOCATION = "ipc://$(pwd())/pub.ipc" # change to tcp if on separate machines
const TOGLOCATION = "ipc://$(pwd())/tog.ipc" # change to tcp if on separate machines

function awaken(gods)
    Pkg.update()
    TOGZMQServer.awaken(router=ROUTERLOCATION,pub=PUBLOCATION,tog=TOGLOCATION, ω=Ω)
    TOGCommunicationServer.awaken(router=ROUTERLOCATION, pub=PUBLOCATION)
    [TOGInstall.awakengod(name=god, router=ROUTERLOCATION, pub=PUBLOCATION, tog=TOGLOCATION, replport=TOGInstall.openport()) for god = gods]
    TOGREPL.awaken(true)
end

# function (@main)(ARGS)
#     # Pkg.update()
#     # manifest = joinpath(dirname(Pkg.project().path), "Manifest.toml")
#     # prehash = hash(read(manifest))
#     # Pkg.update()
#     # posthash = hash(read(manifest))
#     # updated = prehash != posthash
#     # if updated
#     #     run(`tog `)
#     #     exit(0)
#     # end
#     # DEPOT_PATH[1]=joinpath(pwd(),".loopos")
#     config = parse_commandline()
#     if config["update"]
#         Pkg.update()
#         Pkg.Apps.update("tog")
#         return
#     end
#     TOGInstall.awaken()
# end

end
