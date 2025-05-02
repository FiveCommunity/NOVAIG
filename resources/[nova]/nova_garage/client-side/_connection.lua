local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

clientFunctions = {}

Tunnel.bindInterface("vrp_garage", clientFunctions)

serverFunctions = Tunnel.getInterface("vrp_garage")

-- TEMPORARY TABLES

garages = garagesLocs
types = typeGarages

nearestGarages = {}
blockDuplicate = {}
opennedGarageId = 0
opennedGarageType = ""
segundos = 0
lock = false
vehicleClasses = { [0] = "vehicle", [1] = "vehicle", [2] = "vehicle", [3] = "vehicle", [4] = "vehicle", [5] = "vehicle", [6] = "vehicle", [7] = "vehicle", [8] = "vehicle", [9] = "vehicle", [10] = "vehicle", [11] = "vehicle", [12] = "vehicle", [13] = "vehicle", [14] = "boat", [15] = "heli", [16] = "heli", [17] = "vehicle", [18] = "vehicle", [19] = "vehicle", [20] = "vehicle", }


vehicleClassesTranslated = {
    [0] = "Compacto",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupé",
    [4] = "Muscle",
    [5] = "Clássico Esportivo",
    [6] = "Esportivo",
    [7] = "Super",
    [8] = "Motocicleta",
    [9] = "Off-road",
    [10] = "Industrial",
    [11] = "Utilitário",
    [12] = "Van",
    [13] = "Bicicleta",
    [14] = "Barco",
    [15] = "Helicóptero",
    [16] = "Avião",
    [17] = "Serviço",
    [18] = "Emergência",
    [19] = "Militar",
    [20] = "Comercial",
    [21] = "Trem"
}