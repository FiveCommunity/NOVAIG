RegisterNUICallback('getRoles', function(data, cb)
    cb(ServerAPI.getRolesPermissions())
end)

RegisterNUICallback('editRole', function(data, cb)
    local role = data.role
    cb(ServerAPI.updateRolePermissions(role))
end)