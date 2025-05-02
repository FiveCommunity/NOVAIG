RegisterNuiCallback('GetRegisters', function(data, cb)
    cb(vTunnel.getLogs())
end)