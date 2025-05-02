local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

clientFunctions = {}

Tunnel.bindInterface("vrp_roupas", clientFunctions)

serverFunctions = Tunnel.getInterface("vrp_roupas")

-- TEMPORARY TABLES

cam = -1

skinData = {}
oldData = {}
previousSkinData = {}

blipsInMap = {}

customCamLocation = nil
creatingCharacter = false