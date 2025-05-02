------------------------------------------------------------------------------------------------------------------------
-- PLAYER WEAPONS
------------------------------------------------------------------------------------------------------------------------
Weapons = {}
SkinsActived = {}
------------------------------------------------------------------------------------------------------------------------
-- FECHAR UI
------------------------------------------------------------------------------------------------------------------------
local Background = false
local WeaponObject = nil
local weaponName = nil
local weaponComponent = nil
local View = false
------------------------------------------------------------------------------------------------------------------------
-- FECHAR UI
------------------------------------------------------------------------------------------------------------------------
local function onCloseInterface(onClose)
    SetNuiFocus(false,false)
    if not onClose then 
        SendNUIMessage({ action = 'close' })
    end
    
    zoomWeapon(false,false)
    TriggerEvent("flaviin:toggleHud",true)
end
------------------------------------------------------------------------------------------------------------------------
-- OPEN UI
------------------------------------------------------------------------------------------------------------------------

function onOpenInterface()
    if GetEntityHealth(PlayerPedId()) <= 101 then 
        return 
    end 

    local isOpen = serverAPI.openInterface()
    if not isOpen then return end 


    SetNuiFocus(true,true)
    SendNUIMessage({ action = 'open', data =  { page = 'home' } })
    TriggerEvent("flaviin:toggleHud",false)
    
    if not Background then 
        zoomWeapon(true,true)
    end

end

exports("showInterface",onOpenInterface)
------------------------------------------------------------------------------------------------------------------------
-- COMMAND TO OPEN
------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skins", function(_, args, rawCommand)
    onOpenInterface()
end)
------------------------------------------------------------------------------------------------------------------------
-- PURCHASE WEAPONS
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Purchase", function(Data,Callback)    
    local response,playerWeapons = serverAPI.buyWeapons(Data)
    if type(response) == "boolean" then 
        onCloseInterface()
        if not response then 
            return false
        end
    end
    
    for k,v in pairs(playerWeapons) do 
        if not Weapons[GetHashKey(v.weapon)] then 
            Weapons[GetHashKey(v.weapon)] = {}
        end

        table.insert(Weapons[GetHashKey(v.weapon)],{
            name = v.name,
            weapon = v.weapon,  
        })
    end

    Callback(response)
end)
------------------------------------------------------------------------------------------------------------------------
-- GET SKINS
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetSkins", function(Data,Callback)  
    local sendList = {}
    for category,weapons in pairs(Shared.Weapons) do 
        for weapon,weaponInfos in pairs(Shared.Weapons[category]) do 
            if Data.category == weaponInfos.Name then 
                for _,v in pairs(Shared.Weapons[category][weapon].Components) do 
                    table.insert(sendList,{
                        name = v.name, 
                        weapon = weaponInfos.Weapon,
                        rarity = v.rarity, 
                        image = v.image or "https://cdn.discordapp.com/attachments/1187649676825071688/1224888399291486388/image.png?ex=661f2137&is=660cac37&hm=2e95cdcaa57aaacd36d816db78aba8163761a34bb15b67ae392c351119d161b9&", 
                        textureImage = v.textureImage,
                    })  
                end
   
            end
        end
    end

    for i,v in pairs(sendList) do 
        local weaponHash = GetHashKey(v.weapon)
        if Weapons[weaponHash] then                 
            for _,weapon in pairs(Weapons[weaponHash]) do 
                if v.name == weapon.name then 
                    sendList[i].have = true 
                    if SkinsActived[weaponHash] and SkinsActived[weaponHash].name == v.name then 
                        sendList[i].selected = true 
                    end
                end
            end
        end
    end

    Callback(sendList)
end)
------------------------------------------------------------------------------------------------------------------------
-- GET WEAPONS
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetWeapons", function(Data, Callback)
    local sendList = {}
    for k,v in pairs(Shared.Weapons) do 
        if not sendList[k] then 
            sendList[k] = {}
        end

        for weapon,weaponInfos in pairs(Shared.Weapons[k]) do 
            table.insert(sendList[k],{ 
                name = weaponInfos.Name,
                image = weaponInfos.Image,
            })
        end
    end


    
    for _,weapon in pairs(Weapons) do 
        if Weapons[_] and sendList[weapon.category] then 
            for index, v in pairs(sendList[weapon.category]) do 
                if sendList[weapon.category][index].name == weapon.name then 
                    sendList[weapon.category][index].have = true 

                    if weapon.selected then 
                        sendList[weapon.category][index].selected = true 
                    end
                end

            end
        end
    end

    Callback(sendList)
end)
------------------------------------------------------------------------------------------------------------------------
-- STORE WEAPONS
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetStore", function(_, Callback)    
    local storeWeapons = Shared.Store
    if next(Weapons) then 
        for k,v in pairs(Weapons) do 
            for i = 1, #storeWeapons do
                if storeWeapons[i].name == v.name then 
                    storeWeapons[i].have = true 
                end
            end
        end
    end


    Callback({ store = bannerWeapon, weapons = storeWeapons, points = serverAPI.getMakapoints() })
end)
------------------------------------------------------------------------------------------------------------------------
-- SELECIONAR ARMA
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SelectWeapon", function(data, Callback)
    local function findWeaponInfo()
        for _, weaponCategory in pairs(Shared.Weapons) do
            for _, weapon in pairs(weaponCategory) do
                if weapon.Name == data.category then
                    for _, component in pairs(weapon.Components) do
                        if data.skin.name == component.name then
                            return weapon.Weapon, component.component
                        end
                    end
                end
            end
        end
    end


    weaponName,weaponComponent = findWeaponInfo()
    if not weaponName or not weaponComponent then
        return
    end

    weaponName = weaponName:lower()
    local weaponHash = GetHashKey(weaponName)
    RequestWeaponAsset(weaponHash,31,0)
    while not HasWeaponAssetLoaded(weaponHash) do
        Wait(1)
    end
 
    modelComponent = data.skin.name
    weaponComponent = GetHashKey(weaponComponent)

    local componentModel = GetWeaponComponentTypeModel(weaponComponent)
    RequestModel(componentModel)
    while not HasModelLoaded(componentModel) do
        Wait(1)
    end
    
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local Hash = GetHashKey(weaponName)
    local Object = CreateWeaponObject(Hash,0,Coords[1],Coords[2],Coords[3],true,0.0,0)
    GiveWeaponComponentToWeaponObject(Object,weaponComponent)
    GiveWeaponObjectToPed(Object,Ped)
    Wait(200)

    RemoveWeaponComponentFromPed(Ped,weaponName,weaponComponent)
    RemoveWeaponFromPed(Ped,weaponName)
    View = true
    zoomWeapon(true,false)

    Callback(true)

    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false,false)
end)
------------------------------------------------------------------------------------------------------------------------
-- CLOSE UI
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(_, Callback)
    Callback(true)
    onCloseInterface(true)
end)
------------------------------------------------------------------------------------------------------------------------
-- LOAD RESOURCE
------------------------------------------------------------------------------------------------------------------------
AddEventHandler("systemWeapons:Apply",function(hashModel)
    local Ped = PlayerPedId()

    local function GetWeaponComponent(Name,Weapon)
        for category,_ in pairs(Shared.Weapons) do 
            if Shared.Weapons[category] and Shared.Weapons[category][Weapon] then 
                for _,v in pairs(Shared.Weapons[category][Weapon].Components) do 
                    if v.name == Name then 
                        return v.component
                    end
                end
            end 
        end


        return nil 
    end

    if not SkinsActived[hashModel] then 
        return 
    end

    local WeaponComponent = GetWeaponComponent(SkinsActived[hashModel].name,SkinsActived[hashModel].weapon)
    if WeaponComponent then 
        GiveWeaponComponentToPed(Ped,hashModel,WeaponComponent)
    end
end)
------------------------------------------------------------------------------------------------------------------------
-- LOAD RESOURCE
------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Skins:SyncWeapons",function(Data)
    for k,v in pairs(Data) do 
        if not Weapons[GetHashKey(v.weapon)] then 
            Weapons[GetHashKey(v.weapon)] = {}
        end

        table.insert(Weapons[GetHashKey(v.weapon)],{
            name = v.name,
            weapon = v.weapon,  
            category = v.category,
        })  

        if v.selected then 
            SkinsActived[GetHashKey(v.weapon)] = { name = v.name, weapon = v.weapon:upper() }
        end
    end    
end)
------------------------------------------------------------------------------------------------------------------------
-- DISPLAY DA ARMA
------------------------------------------------------------------------------------------------------------------------
function zoomWeapon(bool,first)
    if bool then
        local Ped = PlayerPedId()
        local lastRotation = vector3(0.0,0.0,-45.0)
        local Coords = GetEntityCoords(Ped)
        if first then
            Background = true

            local weaponHash = GetHashKey("WEAPON_COMBATPISTOL")
            RequestWeaponAsset(weaponHash,31,0)
	        while not HasWeaponAssetLoaded(weaponHash) do
                Wait(1)
            end

            WeaponObject = CreateWeaponObject(weaponHash,0,Coords[1],Coords[2],Coords[3]-100.0,true,0.0,0)
            weaponBox = CreateObject(GetHashKey("mt_boxpreta"),Coords[1]+2.4,Coords[2],Coords[3]-102.0,false,false,0)

            SetEntityRotation(WeaponObject,lastRotation)
            FreezeEntityPosition(WeaponObject,true)

            local offset2 = GetOffsetFromEntityInWorldCoords(WeaponObject,1.0,1.0,0.0)

            cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offset2,0.0,0.0,0,60.00,false,0)
            PointCamAtEntity(cam3,WeaponObject,0,0,0,true)
            SetCamFov(cam3,getWeaponFOV(weaponHash))
            SetCamActive(cam3,true)
            RenderScriptCams(true,false,1,true,true)

            DeleteEntity(WeaponObject)
        else
            if WeaponObject ~= nil then
                DeleteEntity(WeaponObject)
            end
            
            local weaponHash = GetHashKey(weaponName)
            WeaponObject = CreateWeaponObject(weaponHash,0,Coords[1],Coords[2],Coords[3]-100.0,true,0.0,0)
            GiveWeaponComponentToWeaponObject(WeaponObject,weaponComponent)

            GiveWeaponObjectToPed(WeaponObject,Ped)

            WeaponObject = GetWeaponObjectFromPed(Ped,true)
            SetEntityCoords(WeaponObject,Coords[1],Coords[2],Coords[3]-100.0)

            RemoveWeaponComponentFromPed(Ped,weaponName,weaponComponent)
            RemoveWeaponFromPed(Ped,weaponName)

            SetEntityRotation(WeaponObject,lastRotation)
            FreezeEntityPosition(WeaponObject,true)

            PointCamAtEntity(cam3,WeaponObject,0,0,0,true)
            SetCamFov(cam3,getWeaponFOV(weaponHash))
        end
    else
        View = false 
        if WeaponObject ~= nil then
            DeleteEntity(WeaponObject)
        end

        DeleteEntity(weaponBox)
        SetArtificialLightsState(false)
        NetworkClearClockTimeOverride()

        SetTimecycleModifier("default")
        DestroyCam(cam3,true)
        RenderScriptCams(false,false,1,true,true)

        Background = false
    end
end
------------------------------------------------------------------------------------------------------------------------
-- ZOOM +
------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    RegisterKeyMapping("ViewA","Rotacionar para a Direita","keyboard","A")
    RegisterKeyMapping("ViewB","Rotacionar para a Esquerda","keyboard","D")
    RegisterKeyMapping("SelectWeapon","Equipar a skin selecionada","keyboard","E")
    RegisterKeyMapping("SelectWeapon2","Desequipar todas skins da Arma","keyboard","S")
    RegisterKeyMapping("close_view","Close Weapon Menu","keyboard","ESCAPE")

    RegisterCommand("ViewA", function(_, args, rawCommand)
        if not View then return end 
        weaponRotation = GetEntityRotation(WeaponObject)


        if WeaponObject then
            local x = 10
            SetEntityRotation(WeaponObject, weaponRotation[1], 0.0, weaponRotation[3] - x)
        end
    end)

    RegisterCommand("ViewB", function(_, args, rawCommand)
        if not View then return end 
        weaponRotation = GetEntityRotation(WeaponObject)

        if WeaponObject then
            local x = 10
            SetEntityRotation(WeaponObject, weaponRotation[1], 0.0, weaponRotation[3] + x)
        end
    end)

    RegisterCommand("SelectWeapon2", function(_, args, rawCommand)
        if not View then return end 

        if SkinsActived[weaponHash] then 
            SkinsActived[weaponHash] = nil 
            serverAPI.selectSkin(modelComponent,weaponName:upper(),false)
            ExecuteCommand("close_view")
            TriggerEvent("Notify","sucesso","Todas skins da arma foram desequipadas.",5)
            return 
        end

        ExecuteCommand("close_view")
        TriggerEvent("Notify","sucesso","Você não possuí essa skin.",5)
    end)

    RegisterCommand("SelectWeapon", function(_, args, rawCommand)
        if not View then return end 
    
        local toUseSkin = false 
        local weaponHash = GetHashKey(weaponName)
        for k,v in pairs(Weapons[weaponHash]) do 
            if v.name == modelComponent then 
                toUseSkin = true 
                break 
            end
        end

        if Weapons[weaponHash] and toUseSkin then            
            SkinsActived[weaponHash] = { name = modelComponent, weapon = weaponName:upper() }

            serverAPI.selectSkin(modelComponent,weaponName:upper(),true)

            ExecuteCommand("close_view")
            TriggerEvent("Notify","sucesso","A Skin foi Ativada",5)
            return  
        end

        ExecuteCommand("close_view")
        TriggerEvent("Notify","sucesso","Você não possuí essa skin.",5)
    end)

    RegisterCommand("close_view",function(_,Args,rawCmd)
        if View then 
            zoomWeapon(false,false)
            TriggerEvent("flaviin:toggleHud",true)
        end
    end)
end)
------------------------------------------------------------------------------------------------------------------------
-- ILUMINAÇÃO
------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local TimeDistance = 500
        if View then
            TimeDistance = 0

            local x,y,z = table.unpack(GetEntityCoords(WeaponObject,true))
            SetArtificialLightsState(true)
            NetworkOverrideClockTime(6,15,00)
            DrawSpotLight(x,y+10.0,z+10.2,10,-10.0,-15.0,100,100,100,15.0,4.0,2.0,20.0,0.0)

            onTextScreen("~b~A~w~ e ~b~D~w~ PARA ROTACIONAR",4,0.5,0.90,0.50,255,255,255,120)
            onTextScreen("~b~E~w~ PARA EQUIPAR",4,0.5,0.93,0.50,255,255,255,120)
            onTextScreen("~b~S~w~ PARA DESEQUIPAR TODAS",4,0.5,0.96,0.50,255,255,255,120)
        end

        Wait(TimeDistance)
    end
end)
------------------------------------------------------------------------------------------------------------------------
-- VIEW SKIN
------------------------------------------------------------------------------------------------------------------------
exports("Status",function()
    return View
end)
------------------------------------------------------------------------------------------------------------------------
-- SYNC ON ENSURE
------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(15000)
    if next(Weapons) then 
        return 
    end
    

    local playerWeapons = serverAPI.playerWeapons()
    for k,v in pairs(playerWeapons) do 
        if not Weapons[GetHashKey(v.weapon)] then 
            Weapons[GetHashKey(v.weapon)] = {}
        end

        table.insert(Weapons[GetHashKey(v.weapon)],{
            name = v.name,
            weapon = v.weapon,  
            category = v.category,
        })  

        if v.selected then 
            SkinsActived[GetHashKey(v.weapon)] = { name = v.name, weapon = v.weapon:upper() }
        end
    end   
end)
------------------------------------------------------------------------------------------------------------------------
-- DRAW TEXT
------------------------------------------------------------------------------------------------------------------------
function onTextScreen(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end