local isServer = IsDuplicityVersion()
local ResourceName = GetCurrentResourceName()

Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

if isServer then
    vRP = Proxy.getInterface("vRP")
    vRPclient = Tunnel.getInterface("vRP")

    Server = {}
    Tunnel.bindInterface(ResourceName, Server)

    TunnelClient = Tunnel.getInterface(ResourceName)
else
    vRP = Proxy.getInterface("vRP")

    Client = {}
    Tunnel.bindInterface(ResourceName, Client)

    TunnelServer = Tunnel.getInterface(ResourceName)
end