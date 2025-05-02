Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
Tools = module("vrp","lib/Tools")
Resource = GetCurrentResourceName()
SERVER = IsDuplicityVersion()

tn = tonumber
ts = tostring

if SERVER then
    vRP = Proxy.getInterface("vRP")
    vRPclient = Tunnel.getInterface("vRP")

    CreateTunnel = {}
    Tunnel.bindInterface(Resource, CreateTunnel)

    Execute = Tunnel.getInterface(Resource)

    function secondsToDay(time)
        local calc = (time / (24 * 60 * 60) )
        return math.floor(calc)
    end
else
    vRP = Proxy.getInterface("vRP")

    CreateTunnel = {}
    Tunnel.bindInterface(Resource, CreateTunnel)

    Execute = Tunnel.getInterface(Resource)
end