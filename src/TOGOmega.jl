module TOGOmega

const T = Float32
export T

using Pkg, Serialization
using TOG: 𝕋, t
using TOGZMQServer, TOGCommunicationServer, TOGAwaken

const Ωpath = joinpath(TOGAwaken.TOGDIR, "Ω")
const Ω = isfile(Ωpath) ? deserialize(Ωpath) : 𝕋()

function awaken(; router=TOGAwaken.router(), pub=TOGAwaken.pub(), tog=TOGAwaken.tog())
    @show getpid(), TOGAwaken.isrunning!()
    TOGAwaken.isrunning!() && error("TOGOmega is already running.")
    TOGAwaken.writepid()
    TOGZMQServer.awaken(router=router, pub=pub, tog=tog, ω=Ω)
    TOGCommunicationServer.awaken(router=router, pub=pub)
    @show "TOGOmega.jl is awake."
end

# __precompile__(false)
function __init__()
    atexit(_ -> begin
        @show "exiting ", Ωpath
        serialize(Ωpath, Ω)
        TOGAwaken.rmpid()
    end)
end
# __precompile__(true)

end
