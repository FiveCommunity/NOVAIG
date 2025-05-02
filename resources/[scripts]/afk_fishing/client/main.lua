local object = nil
function CarregarObjeto(dict,anim,prop,flag,mao,altura,pos1,pos2,pos3)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end
    if object and DoesEntityExist(object) then
        DeleteEntity(object)
    end
    vRP.CarregarAnim(dict)
    TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
    local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
    object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,false,true,true)
    SetEntityCollision(object,false,false)
    TriggerEvent("setProp", object)
    AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,mao),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	SetEntityAsMissionEntity(object,true,true)
end

local function doPed(hash, coords)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    local ped = CreatePed(4, hash, coords.x, coords.y, coords.z - 1.0, coords.w or 100.0, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    PlaceObjectOnGroundProperly(ped, true)
    SetTimeout(3000, function() 
        FreezeEntityPosition(ped, true)
    end)
    return ped
end

local isWorking = false
function API.forceFishStop()
    if object then
        DeleteEntity(object)
        object = nil
    end
    ClearPedTasks(PlayerPedId())
    isWorking = false
    ClearPedTasksImmediately(PlayerPedId())
end

function WorkingThread(slotCoords)
    SetPlayerControl(PlayerId(), false, 1 << 8)
    CreateThread(function ()
    isWorking = true
    local ui = GetMinimapAnchor()
    while isWorking do
        if IsControlJustPressed(0, 168) or IsDisabledControlJustPressed(0, 168) then
            Remote.LeaveFishing()
            break
        end
        local ply = PlayerPedId()
        local coords = GetEntityCoords(ply)
        local distance = #(coords - vec3(slotCoords.x, slotCoords.y, slotCoords.z))
        if distance > 2 then
            SetEntityCoords(ped, slotCoords.x, slotCoords.y, slotCoords.z )
            SetEntityHeading(ped, slotCoords.w)
        end
        if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_b", 3) or not DoesEntityExist(object) then
            CarregarObjeto("amb@world_human_stand_fishing@idle_a","idle_b", "prop_fishing_rod_01",49,60309)
        end
        Draw2DText(ui.right_x-0.139,ui.bottom_y-0.24,1.0,1.0,0.45,"PRESSIONE ~r~F7 ~w~PARA ENCERRAR",255,255,255,150)

        Wait(0)
    end
    ClearPedTasksImmediately(PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if object and DoesEntityExist(object) then
        DeleteEntity(object)
    end
    SetPlayerControl(PlayerId(), true)
end)
end

function Draw2DText(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(6)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextDropShadow(0, 0, 0, 0, 200)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end


CreateThread(function()
    SetPlayerControl(PlayerId(), true)
    ClearPedTasksImmediately(PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if object and DoesEntityExist(object) then
        DeleteEntity(object)
    end
    local pedMarker = doPed(Config.pedMarker.model, Config.pedMarker.coords)
    local PEDMARKER_VEC3 = vec3(Config.pedMarker.coords.x, Config.pedMarker.coords.y, Config.pedMarker.coords.z)
    while true do
        local sleep = 1e3
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local distance = #(coords - PEDMARKER_VEC3)
        if distance < 100 then
            if not DoesEntityExist(pedMarker) then
                pedMarker = doPed(Config.pedMarker.model, Config.pedMarker.coords)
            end
        end
        if distance < 6 then
            sleep = 0
            DrawText3D(PEDMARKER_VEC3.x, PEDMARKER_VEC3.y, PEDMARKER_VEC3.z + 0.2, '~r~[E]~w~ Pesca')
            if distance <= 2 and IsControlJustReleased(0, 38) then
                local res, err = Remote.JoinFishing()
                
                if res then
                    local randomSlot = Config.slots[math.random(1, #Config.slots)]
                    SetEntityCoords(ped, randomSlot.x, randomSlot.y, randomSlot.z )
                    SetEntityHeading(ped, randomSlot.w)
                    CarregarObjeto("amb@world_human_stand_fishing@idle_a","idle_b", "prop_fishing_rod_01",49,60309)
                    WorkingThread(randomSlot)
                else
                    TriggerEvent("Notify","negado",err)
                end
                Wait(2e3)
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,10 ,10, 10,120)
	ClearDrawOrigin()
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end
