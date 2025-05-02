local Tunnel        <const> = module("vrp","lib/Tunnel")
local RESOURCE_NAME <const> = GetCurrentResourceName()
local Proxy         <const> = module("vrp","lib/Proxy")
local Tools         <const> = module("vrp","lib/Tools")
_G.API                      = {}
vRP                         = Proxy.getInterface("vRP")
Tunnel.bindInterface(RESOURCE_NAME,API)
Remote = Tunnel.getInterface(RESOURCE_NAME)
vRPC = Tunnel.getInterface('vRP')