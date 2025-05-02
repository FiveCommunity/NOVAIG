local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","mirtin_survival")

src = {}
Tunnel.bindInterface("mirtin_survival",src)

vSERVER = Tunnel.getInterface("mirtin_survival") 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cfg = {}

cfg.versionNUI = true -- Tela de Morte Versão com NUI
cfg.deathNUItimer = 0 -- Tempo de morte que o jogador vai conseguir utilizar o botao de desistir imediatamente
cfg.deathtimer = 300 -- Tempo in coma
cfg.minHealth = 101 -- o Minimo de vida do seu servidor
cfg.maxHealth = 300 -- o Minimo de vida do seu servidor
cfg.cooldown = 5 -- Delay por pessoa, para evitar FLOODS de Logs no DISCORD [ OBS: Deixar sempre maior que 10 ]
cfg.respawn = vec3(340.48,-1396.58,32.5) -- Localização quando o jogador respawnar
cfg.timedown = false -- Quando acabar os segundos de vida o jogador morrer automaticamente.

cfg.clearAccount = function() -- Limpar a conta do player quando morrer
    vSERVER.limparConta() 
    TriggerEvent("awidj21312390wdn",0)
end

cfg.animDeath = function() -- Animação quando o jogador morrer
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped,"misslamar1dead_body","dead_idle",3) then -- Caso voce queira utilizar por animação
        vRP.playAnim(false,{{"misslamar1dead_body","dead_idle"}},true)
    end 
    -- SetPedToRagdoll(ped, 1500, 1500,0, 0, 0, 0)
end

cfg.drawtext = function(deathtimer) -- Caso você não use a versão com NUI configurar aqui
    if deathtimer > 0 then
        drawTxt("VOCE ESTÁ INCONSCIENTE, TEM ~r~"..deathtimer.." ~w~SEGUNDOS DE OXIGÊNIO, CHAME OS PARAMEDICOS",4,0.5,0.93,0.50,255,255,255,255)
        StartScreenEffect("DeathFailMPIn",0,true)
    else
        if not cfg.timedown then
            drawTxt("PRESSIONE ~w~[~g~E~w~] PARA VOLTAR AO HOSPITAL OU AGUARDE UM PARAMÉDICO",4,0.5,0.93,0.50,255,255,255,255)
            if IsControlJustPressed(0,38) and not IsEntityAttached(PlayerPedId()) then
                morrer()
                StopScreenEffect("DeathFailMPIn")
            end
        end
    end
end

local in_paintball = false
local in_arena = false

cfg.dependencys = function() -- Coloque aqui suas dependencias de scripts para não dar conflito ex: nation_paintball, arenapvp
    if in_paintball then
        return false
    end

    if in_arena then
        return false
    end

    if LocalPlayer.state.inPvP then
        return false
    end
	
	return true
end

RegisterNetEvent("mirtin_survival:updateArena")
AddEventHandler("mirtin_survival:updateArena", function(boolean)
    in_arena = boolean
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG MOTIVOS DAS MORTES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cfg.reasons = {
    [0] = "Não especificado",
    [-1569615261] = "Soco",
    [-100946242] = "Animal",
    [148160082] = "Puma",
    [615608432] = "Molotov",
    [101631238] = "Extintor de Incendio",
    [600439132] = "Arma Bola de Tenis",
    [-1090665087] = "Missel Teleguiado",
    [1223143800] = "Espinhos",
    [-10959621] = "Afogamento",
    [1936677264] = "Afogamento com Veiculo",
    [-1955384325] = "Sangrando",
    [-1833087301] = "Eletrocutado",
    [539292904] = "Explosão",
    [-842959696] = "Pulou de um lugar muito alto",
    [910830060] = "ExaustÃo",
    [133987706] = "Prensado por Veiculo",
    [-1553120962] = "Atropelado",
    [341774354] = "WEAPON_HELI_CRASH",
    [-544306709] = "Pegando fogo",
    [GetHashKey("WEAPON_DAGGER")] = "WEAPON_DAGGER",
    [GetHashKey("WEAPON_BAT")] = "WEAPON_BAT",
    [GetHashKey("WEAPON_BOTTLE")] = "WEAPON_BOTTLE",
    [GetHashKey("WEAPON_CROWBAR")] = "WEAPON_CROWBAR",
    [GetHashKey("WEAPON_UNARMED")] = "WEAPON_UNARMED",
    [GetHashKey("WEAPON_FLASHLIGHT")] = "WEAPON_FLASHLIGHT",
    [GetHashKey("WEAPON_GOLFCLUB")] = "WEAPON_GOLFCLUB",
    [GetHashKey("WEAPON_HAMMER")] = "WEAPON_HAMMER",
    [GetHashKey("WEAPON_HATCHET")] = "WEAPON_HATCHET",
    [GetHashKey("WEAPON_KNUCKLE")] = "WEAPON_KNUCKLE",
    [GetHashKey("WEAPON_KNIFE")] = "WEAPON_KNIFE",
    [GetHashKey("WEAPON_MACHETE")] = "WEAPON_MACHETE",
    [GetHashKey("WEAPON_SWITCHBLADE")] = "WEAPON_SWITCHBLADE",
    [GetHashKey("WEAPON_NIGHTSTICK")] = "WEAPON_NIGHTSTICK",
    [GetHashKey("WEAPON_WRENCH")] = "WEAPON_WRENCH",
    [GetHashKey("WEAPON_BATTLEAXE")] = "WEAPON_BATTLEAXE",
    [GetHashKey("WEAPON_POOLCUE")] = "WEAPON_POOLCUE",
    [GetHashKey("WEAPON_STONE_HATCHET")] = "WEAPON_STONE_HATCHET",
    [GetHashKey("WEAPON_PISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_PISTOL_MK2")] = "WEAPON_PISTOL_MK2",
    [GetHashKey("WEAPON_COMBATPISTOL")] = "WEAPON_COMBATPISTOL",
    [GetHashKey("WEAPON_APPISTOL")] = "WEAPON_APPISTOL",
    [GetHashKey("WEAPON_DOUBLEACTION")] = "WEAPON_DOUBLEACTION",
    [GetHashKey("WEAPON_STUNGUN")] = "WEAPON_STUNGUN",
    [GetHashKey("WEAPON_PISTOL50")] = "WEAPON_PISTOL50",
    [GetHashKey("WEAPON_SNSPISTOL")] = "WEAPON_SNSPISTOL",
    [GetHashKey("WEAPON_SNSPISTOL_MK2")] = "WEAPON_SNSPISTOL_MK2",
    [GetHashKey("WEAPON_HEAVYPISTOL")] = "WEAPON_HEAVYPISTOL",
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = "WEAPON_VINTAGEPISTOL",
    [GetHashKey("WEAPON_FLAREGUN")] = "WEAPON_FLAREGUN",
    [GetHashKey("WEAPON_MARKSMANPISTOL")] = "WEAPON_MARKSMANPISTOL",
    [GetHashKey("WEAPON_REVOLVER")] = "WEAPON_REVOLVER",
    [GetHashKey("WEAPON_REVOLVER_MK2")] = "WEAPON_REVOLVER_MK2",
    [GetHashKey("WEAPON_DOUBLEACTION")] = "WEAPON_DOUBLEACTION",
    [GetHashKey("WEAPON_RAYPISTOL")] = "WEAPON_RAYPISTOL",
    [GetHashKey("WEAPON_CERAMICPISTOL")] = "WEAPON_CERAMICPISTOL",
    [GetHashKey("WEAPON_NAVYREVOLVER")] = "WEAPON_NAVYREVOLVER",
    [GetHashKey("WEAPON_GADGETPISTOL")] = "WEAPON_GADGETPISTOL",
    [GetHashKey("WEAPON_STUNGUN_MP")] = "WEAPON_STUNGUN_MP",
    [GetHashKey("WEAPON_MICROSMG")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_SMG")] = "WEAPON_SMG",
    [GetHashKey("WEAPON_SMG_MK2")] = "WEAPON_SMG_MK2",
    [GetHashKey("WEAPON_ASSAULTSMG")] = "WEAPON_ASSAULTSMG",
    [GetHashKey("WEAPON_COMBATPDW")] = "WEAPON_COMBATPDW",
    [GetHashKey("WEAPON_MACHINEPISTOL")] = "WEAPON_MACHINEPISTOL",
    [GetHashKey("WEAPON_MINISMG")] = "WEAPON_MINISMG",
    [GetHashKey("WEAPON_RAYCARBINE")] = "WEAPON_RAYCARBINE",
    [GetHashKey("WEAPON_PUMPSHOTGUN")] = "WEAPON_PUMPSHOTGUN",
    [GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = "WEAPON_PUMPSHOTGUN_MK2",
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = "WEAPON_SAWNOFFSHOTGUN",
    [GetHashKey("WEAPON_ASSAULTSHOTGUN")] = "WEAPON_ASSAULTSHOTGUN",
    [GetHashKey("WEAPON_BULLPUPSHOTGUN")] = "WEAPON_BULLPUPSHOTGUN",
    [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = "WEAPON_BULLPUPRIFLE_MK2",
    [GetHashKey("WEAPON_COMPACTRIFLE")] = "WEAPON_COMPACTRIFLE",
    [GetHashKey("WEAPON_MILITARYRIFLE")] = "WEAPON_MILITARYRIFLE",
    [GetHashKey("WEAPON_HEAVYRIFLE")] = "WEAPON_HEAVYRIFLE",
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = "WEAPON_ASSAULTRIFLE_MK2",
    [GetHashKey("WEAPON_CARBINERIFLE")] = "WEAPON_CARBINERIFLE",
    [GetHashKey("WEAPON_CARBINERIFLE_MK2")] = "WEAPON_CARBINERIFLE_MK2",
    [GetHashKey("WEAPON_ADVANCEDRIFLE")] = "WEAPON_ADVANCEDRIFLE",
    [GetHashKey("WEAPON_SPECIALCARBINE")] = "WEAPON_SPECIALCARBINE",
    [GetHashKey("WEAPON_PARAFAL")] = "WEAPON_PARAFAL",
    [GetHashKey("WEAPON_TACTICALRIFLE")] = "WEAPON_TACTICALRIFLE",
    [GetHashKey("WEAPON_BULLPUPRIFLE")] = "WEAPON_BULLPUPRIFLE",
    [GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = "WEAPON_SPECIALCARBINE_MK2",
    [GetHashKey("WEAPON_AKPENTEDE90_RELIKIASHOP")] = "WEAPON_AKPENTEDE90_RELIKIASHOP",
    [GetHashKey("WEAPON_AKDEFERRO_RELIKIASHOP")] = "WEAPON_AKDEFERRO_RELIKIASHOP",
    [GetHashKey("WEAPON_AK472")] = "WEAPON_AK472",
    [GetHashKey("WEAPON_AR10PRETO_RELIKIASHOP")] = "WEAPON_AR10PRETO_RELIKIASHOP",
    [GetHashKey("WEAPON_AR15BEGE_RELIKIASHOP")] = "WEAPON_AR15BEGE_RELIKIASHOP",
    [GetHashKey("WEAPON_ARPENTEACRILICO_RELIKIASHOP")] = "WEAPON_ARPENTEACRILICO_RELIKIASHOP",
    [GetHashKey("WEAPON_ARDELUNETA_RELIKIASHOP")] = "WEAPON_ARDELUNETA_RELIKIASHOP",
    [GetHashKey("WEAPON_ARLUNETAPRATA")] = "WEAPON_ARLUNETAPRATA",
    [GetHashKey("WEAPON_ARTAMBOR")] = "WEAPON_ARTAMBOR",
    [GetHashKey("WEAPON_G3LUNETA_RELIKIASHOP")] = "WEAPON_G3LUNETA_RELIKIASHOP",
    [GetHashKey("WEAPON_GLOCKDEROUPA_RELIKIASHOP")] = "WEAPON_GLOCKDEROUPA_RELIKIASHOP",
    [GetHashKey("WEAPON_HKG3A3")] = "WEAPON_HKG3A3",
    [GetHashKey("WEAPON_HK_RELIKIASHOP")] = "WEAPON_HK_RELIKIASHOP",
    [GetHashKey("WEAPON_PENTEDUPLO1")] = "WEAPON_PENTEDUPLO1",
    [GetHashKey("WEAPON_50_RELIKIASHOP")] = "WEAPON_50_RELIKIASHOP",
    [GetHashKey("WEAPON_BULLPUPRIFLE")] = "WEAPON_BULLPUPRIFLE",
    [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = "WEAPON_BULLPUPRIFLE_MK2",
    [GetHashKey("WEAPON_COMPACTRIFLE")] = "WEAPON_COMPACTRIFLE",
    [GetHashKey("WEAPON_HEAVYRIFLE")] = "WEAPON_HEAVYRIFLE",
    [GetHashKey("WEAPON_MG")] = "WEAPON_MG",
    [GetHashKey("WEAPON_COMBATMG")] = "WEAPON_COMBATMG",
    [GetHashKey("WEAPON_COMBATMG_MK2")] = "WEAPON_COMBATMG_MK2",
    [GetHashKey("WEAPON_GUSENBERG")] = "WEAPON_GUSENBERG",
    [GetHashKey("WEAPON_SNIPERRIFLE")] = "WEAPON_SNIPERRIFLE",
    [GetHashKey("WEAPON_HEAVYSNIPER")] = "WEAPON_HEAVYSNIPER",
    [GetHashKey("WEAPON_HEAVYSNIPER_MK2")] = "WEAPON_HEAVYSNIPER_MK2",
    [GetHashKey("WEAPON_MARKSMANRIFLE")] = "WEAPON_MARKSMANRIFLE",
    [GetHashKey("WEAPON_MARKSMANRIFLE_MK2")] = "WEAPON_MARKSMANRIFLE_MK2",
    [GetHashKey("WEAPON_RPG")] = "WEAPON_RPG",
    [GetHashKey("WEAPON_GRENADELAUNCHER")] = "WEAPON_GRENADELAUNCHER",
    [GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE")] = "WEAPON_GRENADELAUNCHER_SMOKE",
    [GetHashKey("WEAPON_MINIGUN")] = "WEAPON_MINIGUN",
    [GetHashKey("WEAPON_FIREWORK")] = "WEAPON_FIREWORK",
    [GetHashKey("WEAPON_RAILGUN")] = "WEAPON_RAILGUN",
    [GetHashKey("WEAPON_HOMINGLAUNCHER")] = "WEAPON_HOMINGLAUNCHER",
    [GetHashKey("WEAPON_COMPACTLAUNCHER")] = "WEAPON_COMPACTLAUNCHER",
    [GetHashKey("WEAPON_RAYMINIGUN")] = "WEAPON_RAYMINIGUN",
    [GetHashKey("WEAPON_EMPLAUNCHER")] = "WEAPON_EMPLAUNCHER",
    [GetHashKey("WEAPON_GRENADE")] = "WEAPON_GRENADE",
    [GetHashKey("WEAPON_BZGAS")] = "WEAPON_BZGAS",
    [GetHashKey("WEAPON_MOLOTOV")] = "WEAPON_MOLOTOV",
    [GetHashKey("WEAPON_STICKYBOMB")] = "WEAPON_STICKYBOMB",
    [GetHashKey("WEAPON_PROXMINE")] = "WEAPON_PROXMINE",
    [GetHashKey("WEAPON_SNOWBALL")] = "WEAPON_SNOWBALL",
    [GetHashKey("WEAPON_PIPEBOMB")] = "WEAPON_PIPEBOMB",
    [GetHashKey("WEAPON_BALL")] = "WEAPON_BALL",
    [GetHashKey("WEAPON_SMOKEGRENADE")] = "WEAPON_SMOKEGRENADE",
    [GetHashKey("WEAPON_FLARE")] = "WEAPON_FLARE",
    [GetHashKey("WEAPON_PETROLCAN")] = "WEAPON_PETROLCAN",
    [GetHashKey("GADGET_PARACHUTE")] = "GADGET_PARACHUTE",
    [GetHashKey("WEAPON_HAZARDCAN")] = "WEAPON_HAZARDCAN",
    [GetHashKey("WEAPON_HAZARDCAN")] = "WEAPON_HAZARDCAN",
    [GetHashKey("WEAPON_FERTILIZERCAN")] = "WEAPON_FERTILIZERCAN",
    
}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DISCONNECT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local allCombats = {}

RegisterNetEvent("anticl")
AddEventHandler("anticl", function(user_id, coords, motivo)
    allCombats[user_id] = { coords = coords, motivo = motivo, time = 30 }
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000

        local pedCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(allCombats) do
            local distance = #(pedCoords - v.coords)
            if distance <= 10 then
                time = 5
                DrawText3D(v.coords[1],v.coords[2],v.coords[3], "~r~Deslogou | "..v.time.." ~n~ ~w~ID: ".. k .."~n~ Motivo: "..v.motivo)
            end
        end

        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(allCombats) do
            if k then
                allCombats[k] = { coords = allCombats[k].coords, motivo = allCombats[k].motivo, time = allCombats[k].time - 1  }

                if v.time <= 0 then
                    allCombats[k] = nil
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255,255,255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
