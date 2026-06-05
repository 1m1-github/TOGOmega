module TOGOmega

const T = Float32
export T

using Pkg, Serialization
using TOG: 𝕋, t
using TOGZMQServer, TOGCommunicationServer, TOGAwaken

const Ωpath = joinpath(TOGAwaken.TOGDIR, "Ω")
const Ω = isfile(Ωpath) ? deserialize(Ωpath) : 𝕋()

function awaken(; router=TOGAwaken.router(), pub=TOGAwaken.pub(), tog=TOGAwaken.tog())
    TOGAwaken.isrunning() && error("TOGOmega is already running.")
    TOGAwaken.writepid()
    TOGZMQServer.awaken(router=router, pub=pub, tog=tog, ω=Ω)
    TOGCommunicationServer.awaken(router=router, pub=pub)
end

function __init__()
    atexit(_ -> begin
        serialize(Ωpath, Ω)
        TOGAwaken.rmpid()
    end)
end

end
