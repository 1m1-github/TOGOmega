module TOGOmega

const T = Float64

using Pkg, Serialization
using TOG: 𝕋
using TOGCommunicationServer, TOGAwaken, TOGLogging, TOGObserveServer, TOGCreateServer
using TOGColor, Colors # DEBUG?

const Ωpath = joinpath(TOGAwaken.TOGDIR, "Ω")
const Ω = isfile(Ωpath) ? deserialize(Ωpath) : 𝕋(T)

__init__() = atexit(sleep)
function sleep()
    # serialize(Ωpath, Ω)
    TOGAwaken.sleep()
    TOGObserveServer.sleep()
    TOGCreateServer.sleep()
    TOGCommunicationServer.sleep()
end
function awaken(; router=TOGAwaken.router(), pub=TOGAwaken.pub(), togobserve=TOGAwaken.togobserve(), togcreate=TOGAwaken.togcreate())
    TOGLogging.awaken()
    TOGAwaken.awaken()
    TOGObserveServer.awaken(socketlocation=togobserve, ω=Ω)
    TOGCreateServer.awaken(socketlocation=togcreate, ω=Ω)
    TOGCommunicationServer.awaken(router=router, pub=pub)
end

end
