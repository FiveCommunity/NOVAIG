Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
resourceName = GetCurrentResourceName()

if IsDuplicityVersion() then
    cfg = module('cfg/groups')
    groups = cfg.groups
    serverAPI = {}
    vRPC = Tunnel.getInterface('vRP')
    Tunnel.bindInterface(resourceName, serverAPI)
    clientAPI = Tunnel.getInterface(resourceName)
else
    clientAPI = {}
    Tunnel.bindInterface(resourceName, clientAPI)
    serverAPI = Tunnel.getInterface(resourceName)
end