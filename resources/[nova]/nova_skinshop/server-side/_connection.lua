local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPClient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

serverFunctions = {}
Tunnel.bindInterface("vrp_roupas", serverFunctions)

clientFunctions = Tunnel.getInterface("vrp_roupas") 