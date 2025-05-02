local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

serverFunctions = {}
Tunnel.bindInterface("vrp_barbearia", serverFunctions)

clientFunctions = Tunnel.getInterface("vrp_barbearia")