local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local serverAPI = Tunnel.getInterface("wall")
local playerList = {}
local inAdminMode = false
local config = {}
characters = {}
local weaponName = {
    [-1569615261] = "",
    [-1716189206] = "Faca",
    [1737195953] = "Cassetete",
    [1317494643] = "Martelo",
    [-1786099057] = "Bastão",
    [-2067956739] = "Pé de cabra",
    [1141786504] = "Taco de Golf",
    [-102323637] = "Garrafa",
    [-1834847097] = "Adaga",
    [-102973651] = "Machado",
    [-656458692] = "Soco Inglês",
    [-581044007] = "Machete",
    [-1951375401] = "Lanterna",
    [-538741184] = "Canivete",
    [-1810795771] = "Taco de Sinuca",
    [419712736] = "Chave Inglêsa",
    [-853065399] = "Machado de Batalha",

    [453432689] = "Pistol",
    [-1075685676] = "Five-Seven",
    [1593441988] = "Combat Pistol",
    [-1716589765] = "Pistol 50",
    [-1076751822] = "SNS Pistol",
    [-771403250] = "Heavy Pistol",
    [137902532] = "Vintage Pistol",
    [-598887786] = "Marksman Pistol",
    [-1045183535] = "Revolver",
    [584646201] = "AP Pistol",
    [911657153] = "Taser",
    [1198879012] = "Sinalizador",

    [324215364] = "Micro SMG",
    [-619010992] = "Machine Pistol",
    [736523883] = "SMG",
    [2024373456] = "SMG MK2",
    [270015777] = "MTAR",
    [171789620] = "Sig Sauer",
    [-1660422300] = "MG",
    [2144741730] =  "CombatMG",
    [3686625920] = "CombatMG MK2",
    [1627465347] = "Thompson",
    [-1121678507] = "Mini SMG",

    [-1074790547] = "Assault Rifle",
    [961495388] = "Assault Rifle MK2",
    [-2084633992] = "Carbine Rifle",
    [-86904375] = "Carbine Rifle MK2",
    [-1357824103] = "Advanced Rifle",
    [-1063057011] = "Special Carbine",
    [-1768145561] = "Special Carbine MK2",
    [2132975508] = "Bullpup Rifle",
    [1649403952] = "Compact Rifle",

    [100416529] = "Sniper Rifle",
    [205991906] = "Heavy Sniper",
    [177293209] = "Heavy Sniper MK2",
    [-952879014] = "Marksman Rifle",

    [487013001] = "Pump Shotgun",
    [2017895192] = "Sawnoff Shotgun",
    [-1654528753] = "Bullpup Shotgun",
    [-494615257] = "Assault Shotgun",
    [-1466123874] = "Musket",
    [984333226] = "Heavy Shotgun",
    [-275439685] = "Double Barrel Shotgun",
    [317205821] = "Auto Shotgun",

    [-1568386805] = "Grenade Launcher",
    [-1312131151] = "RPG",
    [1119849093] = "Minigun",
    [2138347493] = "FireWork",
    [1834241177] = "RailGun",
    [1672152130] = "Homing Launcher",
    [1305664598] = "Grenade Launcher Smoke",
    [125959754] = "Compact Launcher",

    [-1813897027] = "Grenade",
    [741814745] = "Sticky Bomb",
    [-1420407917] = "ProximityMine",
    [-1600701090] = "BZGas",
    [615608432] = "Molotov",
    [101631238] = "Extintor",
    [GetHashKey('WEAPON_PARAFAL')] = "Parafal",
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = "Fajuta",
    [883325847] = "Petrolcan",
    [1233104067] = "Flare",
    [600439132] = "Bola",
    [126349499] = "Bola de Neve",
    [-37975472] = "Smoke Grenade",
    [-1169823560] = "Pipe bomb"
}

RegisterNetEvent("wall:Blips:UpdateList",function(arrayList)
    playerList = arrayList
end)

RegisterNetEvent("wall:Blips:LoadAdminMode",function(userConfig)
    if inAdminMode then
        inAdminMode = false
        serverAPI.unloadInfos()
        TriggerEvent("Notify","negado","Blips desativados.")
    else
        config = userConfig
        inAdminMode = true
        serverAPI.loadInfos()
        startModule()
        TriggerEvent("Notify","sucesso","Blips ativados.")
    end
end)

RegisterNetEvent("wall:UpdateConfig",function(index,status)
    if inAdminMode then
        config[index] = status
    end
end)

function startModule()
    Citizen.CreateThread(function()
        local ped, coords, myServerId, nsource, nped, ncoords, arrayInfos, selectedWeapon, nameWeapon
        while inAdminMode do
            ped = PlayerPedId()
            coords = GetEntityCoords(ped)
            myServerId = GetPlayerServerId(PlayerId())

            for k,v in pairs(GetActivePlayers()) do
                nsource = GetPlayerServerId(v)
                nped = GetPlayerPed(v)
                ncoords = GetEntityCoords(nped)
                if playerList[nsource] and nped and nsource ~= myServerId then 
                    if Vdist(coords.x, coords.y, coords.z, ncoords.x, ncoords.y, ncoords.z) <= 500 then
                        arrayInfos = playerList[nsource]
                        selectedWeapon = GetSelectedPedWeapon(nped) or ' '
                        nameWeapon = weaponName[selectedWeapon]
                        local invisibility = IsEntityVisible(nped) and "~w~" or "~r~ Invisível"
                        local speaking = NetworkIsPlayerTalking(v) and "~y~Falando" or "~w~" 
                        if not nameWeapon then nameWeapon = "Indefinida" end
                        if config.Linhas then 
                            color1,color2,color3 = 3, 28, 252
                            if not IsEntityVisible(nped) then color1,color2,color3 = 168, 24, 17 end
                            DrawLine(coords.x, coords.y, coords.z, ncoords.x, ncoords.y, ncoords.z, color1,color2,color3, 255)
                        end
                        DrawAdmin(ncoords.x,ncoords.y,ncoords.z+1.10,(arrayInfos.staff and "~o~[STAFF]~w~ " or "")..(config.Nome and arrayInfos.steamName or "")..(config.Source and " [S: "..nsource.."]" or "").." (~g~"..(config.Vida and GetEntityHealth(nped)-100 or "").." ~w~| ~b~"..(config.Colete and GetPedArmour(nped) or "").."~w~) "..(GetPlayerStateBagValueByServerId(nsource,'infosWall') == 'Ativado' and "~r~[BLIPS-ON]" or "").." \n~w~(~y~#"..arrayInfos.user_id.." "..arrayInfos.name.."~w~) - ~t~"..arrayInfos.orgName.."\n~b~"..(config.Arma and nameWeapon or "").."\n"..invisibility.."\n"..speaking)
                    end
                end
            end
            Citizen.Wait(0)
        end
    end)
end


RegisterNetEvent("wall:stateUpdate",function(key, value, replicated)
    local serverId = GetPlayerServerId(PlayerId())
    local payload = msgpack.pack(value)
    SetStateBagValue("player:"..serverId, key, payload, payload:len(), replicated or true)
end)

function GetPlayerStateBagValueByServerId(serverId, key)
    return GetStateBagValue("player:"..serverId, key)
end


function DrawAdmin(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        local lineHeight = 0.018 
        local lines = splitString(text, "\n")
        
        for i, line in ipairs(lines) do
            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.25, 0.25)
            SetTextColour(255,255,255,255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 150)
            SetTextDropshadow()
            SetTextOutline()
            SetTextEntry('STRING')
            SetTextCentre(1)
            AddTextComponentString(line)
            DrawText(_x, _y + ((i-1) * lineHeight))
        end
    end
end

function splitString(input, separator)
    if separator == nil then
        separator = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(input, "([^"..separator.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
