local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Client = {}
Tunnel.bindInterface("dynamic",Client)
vSERVER = Tunnel.getInterface("dynamic")