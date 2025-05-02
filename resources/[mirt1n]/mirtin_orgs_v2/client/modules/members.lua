----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetMembers", function(data,cb) 
    cb(vTunnel.getMembers())
end)

RegisterNuiCallback('ContractMember', function(data, cb ) 
    cb(vTunnel.inviteMember(data.id))
end)

RegisterNuiCallback('DemoteMember', function(data, cb ) 
    cb(vTunnel.genMember({ memberId = data.id, action = 'demote' }))
end)
    
RegisterNuiCallback('PromoteMember', function(data, cb ) 
    cb(vTunnel.genMember({ memberId = data.id, action = 'promote' }))
end)

RegisterNuiCallback('DimissMember', function(data, cb ) 
    cb(vTunnel.genMember({ memberId = data.id, action = 'dismiss' }))
end)   