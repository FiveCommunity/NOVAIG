zone = {}
zone.__index = zone
zoneStorage = {}

local function generateRandomHash(length)
    local characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local hash = ''
    
    math.randomseed(os.time())
    
    for i = 1, length do
        local charIndex = math.random(1, #characters)
        hash = hash .. string.sub(characters, charIndex, charIndex)
    end
    
    return hash
end

function zone:new(data)
    local self = setmetatable({}, zone)
    
    assert(data.points, 'zone:new() - points is required')
    assert(data.settings, 'zone:new() - settings is required')
    assert(data.creator, 'zone:new() - creator is required')
    
    self.points = data.points
    self.settings = data.settings
    self.zoneID = generateRandomHash(6)
    self.staff = data.creator
    
    zoneStorage[self.zoneID] = self
    
    -- exports['oxmysql']:executeSync('INSERT INTO invasion_system(`zone`) VALUES(?) ', {json.encode(self)})
    -- clientAPI.syncZone(-1, self)
    
    return self
end

serverAPI.resolveNewZone = function(data)
    local src = source
    local userId = vRP.getUserId(src)
    
    assert(userId, 'resolveNewZone() - userId is nil')
    assert(data.points, 'resolveNewZone() - missing points in data')
    assert(type(data.points) == 'table', 'resolveNewZone() - points data is not a table')
    
    data.settings = invasionsInCreation[userId]
    assert(data.settings, 'resolveNewZone() - trouble retrieving zone settings')
    
    data.creator = userId
    
    zone:new(data)
    serverAPI.requestInvasion()
end

function zone:delete(zoneID)
    if not zoneStorage[zoneID] then
        print(string.format("Zone not found: %s", zoneID))
        return false
    end
    
    zoneStorage[zoneID] = nil
    print(string.format("Zone deleted successfully: %s", zoneID))
    return true
end

serverAPI.resolveDeleteZone = function(key)
    local src = source
    local userId = vRP.getUserId(src)
    assert(userId, 'resolveDeleteZone() - userId is nil')
    
    local zoneFound = false
    
    for zoneID, data in pairs(zoneStorage) do
        if tonumber(data.staff) == tonumber(key) then
            zone:delete(zoneID)
            zoneFound = true
            break
        end
    end
    
    if not zoneFound then
        print(string.format("No zone found for staff: %s", tostring(key)))
    end
end