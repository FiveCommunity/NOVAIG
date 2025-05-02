Televisions = {}
Channels = {}

DEFAULT_URL = "nui://"..GetCurrentResourceName().."/web/tv/index.html"

function DumpArray(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[DumpArray(k, s)] = DumpArray(v, s) end
    return res
end

function GetTelevision(coords)
    for k,v in pairs(Televisions) do 
        if #(vec3(v.coords) - vec3(coords)) < 0.01 then
            return k, v
        end
    end
end