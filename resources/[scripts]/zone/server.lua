
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("zone",src)
Proxy.addInterface("zone",src)

vCLIENT = Tunnel.getInterface("zone")

