-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	if GetPedDrawableVariation(PlayerPedId(),1) == skinData["mask"]["item"] then
		vRP.playAnim(true,{"missfbi4","takeoff_mask"},true)
		Citizen.Wait(900)
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	else
		vRP.playAnim(true,{"mp_masks@on_foot","put_on_mask"},true)
		Citizen.Wait(700)
		SetPedComponentVariation(PlayerPedId(),1,skinData["mask"]["item"],skinData["mask"]["texture"],1)
	end

	vRP.DeletarObjeto("one")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	vRP.playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},true)

	Citizen.Wait(900)

	if GetPedPropIndex(PlayerPedId(),0) == skinData["hat"]["item"] then
		ClearPedProp(PlayerPedId(),0)
	else
		SetPedPropIndex(PlayerPedId(),0,skinData["hat"]["item"],skinData["hat"]["texture"],1)
	end

	vRP.DeletarObjeto("one")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	vRP.playAnim(true,{"clothingspecs","take_off"},true)

	Citizen.Wait(1000)

	if GetPedPropIndex(PlayerPedId(),1) == skinData["glass"]["item"] then
		ClearPedProp(PlayerPedId(),1)
	else
		SetPedPropIndex(PlayerPedId(),1,skinData["glass"]["item"],skinData["glass"]["texture"],2)
	end

	vRP.DeletarObjeto("one")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms", function()
	if GetPedDrawableVariation(PlayerPedId(),3) == skinData["arms"]["item"] then
		SetPedComponentVariation(PlayerPedId(),3,15,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),3,skinData["arms"]["item"],skinData["arms"]["texture"],1)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("mascara")
AddEventHandler("mascara",function(index,color)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP._playAnim(true,{{"missfbi4","takeoff_mask"}},false)
			Wait(700)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"mp_masks@standard_car@ds@","put_on_mask"}},false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("blusa")
AddEventHandler("blusa",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("jaqueta")
AddEventHandler("jaqueta",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			SetPedComponentVariation(ped,11,15,0,2)
			ClearPedTasks(ped)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			SetPedComponentVariation(ped,11,parseInt(index),parseInt(color),2)
			ClearPedTasks(ped)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcolete')
AddEventHandler('setcolete',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			SetPedComponentVariation(ped,9,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("calca")
AddEventHandler("calca",function(index,color)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if index == nil then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
				Wait(3000)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,15,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("maos")
AddEventHandler("maos",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /acess
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("acessorios")
AddEventHandler("acessorios",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			SetPedComponentVariation(ped,7,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("mochila")
AddEventHandler("mochila",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			SetPedComponentVariation(ped,5,42,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			SetPedComponentVariation(ped,5,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			SetPedComponentVariation(ped,5,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("sapatos")
AddEventHandler("sapatos",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
			Wait(3000)
			ClearPedTasks(ped)
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)	
			Wait(3000)
			ClearPedTasks(ped)
				SetPedComponentVariation(ped,6,35,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)		
		Wait(3000)
		ClearPedTasks(ped)
			SetPedComponentVariation(ped,6,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)	
		Wait(3000)
		ClearPedTasks(ped)	
			SetPedComponentVariation(ped,6,parseInt(index),parseInt(color),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("chapeu")
AddEventHandler("chapeu",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","take_off_helmet_stand",1}},false)
		Wait(700)
		ClearPedProp(ped,0)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet",1}},false)
		Wait(1700)
		SetPedPropIndex(ped,0,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet",1}},false)
		Wait(1700)
		SetPedPropIndex(ped,0,parseInt(index),parseInt(color),2)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("oculos")
AddEventHandler("oculos",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		vRP._playAnim(true,{"mini@ears_defenders","takeoff_earsdefenders_idle"},false)
		Wait(400)
		ClearPedTasks(ped)
		ClearPedProp(ped,1)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
		Wait(800)
		ClearPedTasks(ped)
		SetPedPropIndex(ped,1,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
		Wait(800)
		ClearPedTasks(ped)
		SetPedPropIndex(ped,1,parseInt(index),parseInt(color),2)
	end
end)

RegisterNetEvent("orelhas")
AddEventHandler("orelhas",function(index,color)
	local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
		if index == nil then
			vRP.playAnim(true,{"misscommon@std_take_off_masks","take_off_mask_ps",1},false)
			Wait(400)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps",1},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,2,parseInt(index),parseInt(color),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps",1},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,2,parseInt(index),parseInt(color),2)
		end
	end
end)

RegisterCommand("loja2", function()
	if GetEntityHealth(PlayerPedId()) <= 101 then return end
    if serverFunctions.checkPermission() then
        clientFunctions.openNuiShop()
    end
end)