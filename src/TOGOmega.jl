module TOGOmega

export t, T

const T = Float32

using Pkg, Serialization
using TOG: 𝕋
using TOGZMQServer, TOGCommunicationServer, TOGAwaken

const Ωpath = joinpath(TOGAwaken.TOGDIR, "Ω")
const Ω = isfile(Ωpath) ? deserialize(Ωpath) : 𝕋(T)
import TOG: t
t() = t(Ω)

function __init__()
    atexit(_ -> begin
        # serialize(Ωpath, Ω)
        TOGAwaken.rmpid()
    end)
end

function awaken(; router=TOGAwaken.router(), pub=TOGAwaken.pub(), tog=TOGAwaken.tog())
    TOGAwaken.isrunning() && error("TOGOmega is already running.")
    TOGAwaken.writepid()
    TOGZMQServer.awaken(router=router, pub=pub, tog=tog, ω=Ω)
    TOGCommunicationServer.awaken(router=router, pub=pub)
end

end
