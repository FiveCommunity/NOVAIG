local using_bennys = {}

function lBennys.getPermission(perm)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    return vRP.hasPermission(user_id,perm)
end

function lBennys.removeVehicle(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    using_bennys[vehicle] = nil
end

function lBennys.statusVehicle(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end 

    if using_bennys[vehicle] then
        return false
    end

	local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock = vRPC.ModelName(source,7)
	local puser_id = vRP.getUserByRegistration(mPlaca)
	if mPlaca and puser_id then
		local rows = vRP.query("vRP/get_portaMalas",{ user_id = puser_id, veiculo = mName })
		if #rows > 0 then
            using_bennys[vehicle] = true
            return true
		end
	end
    TriggerClientEvent("Notify",source,"negado","Veiculo não encontrado na garagem de nenhum jogador.",5)
    return false
end

function lBennys.saveAttribute(data)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local status = Bennys:saveAttribute(user_id,data)
    return status
end


function lBennys.dataStance()
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = Bennys:infosStance()
    return data
end

function lBennys.saveCustom(typeCustom,dataCustom)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = Bennys:applyCustom(user_id,typeCustom,dataCustom)
    return data
end