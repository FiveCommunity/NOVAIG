Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

local server = IsDuplicityVersion()
if server then
    lBennys = {} -- vrp server => client lBennys
    vRPC = Tunnel.getInterface('vRP')
    Tunnel.bindInterface(GetCurrentResourceName(), lBennys)
    vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
else
    lBennys = {} -- vrp client => server lBennys
    Tunnel.bindInterface(GetCurrentResourceName(), lBennys)
    vSERVER = Tunnel.getInterface(GetCurrentResourceName())
end
