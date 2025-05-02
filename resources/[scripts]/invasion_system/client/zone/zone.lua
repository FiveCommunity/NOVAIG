zone = {}
zone.__index = zone -- metamethod

function zone:handle(data)
    local self = setmetatable({}, zone)

    local points = data.points
    local settings = data.settings 
    local zoneID = data.zoneID

    self.inzone = true
    self.alive = true
    self.active = state.isInInvasion
    self.points = points
    self.settings = settings
    self.zoneID = zoneID
    self.ped = PlayerPedId()
    self.name = ('%s x %s'):format(self.settings.teams.left, self.settings.teams.right)
    self.damageAmount = 10 -- Quantidade de vida perdida por segundo ao sair da zona
    self.damageInterval = 1000 -- Intervalo de dano em milissegundos

    function self:isPlayerInZone()
        return self:IsPointInsidePolygon(GetEntityCoords(self.ped))
    end

    function self:IsPointInsidePolygon(point)
        local polygon = self.points
        local j = #polygon
        local oddNodes = false

        for i = 1, #polygon do
            if (polygon[i].y < point.y and polygon[j].y >= point.y or polygon[j].y < point.y and polygon[i].y >= point.y) then
                if (polygon[i].x + (point.y - polygon[i].y) / (polygon[j].y - polygon[i].y) * (polygon[j].x - polygon[i].x) < point.x) then
                    oddNodes = not oddNodes
                end
            end
            j = i
        end

        return oddNodes
    end

    function self:showPolygon()
        local p1 = self.p1
        local p2 = self.p2

        local bottomLeft = vec3(p1.x, p1.y, p1.z - 150)
        local bottomRight = vec3(p2.x, p2.y, p2.z - 150)
        local topLeft = vec3(p1.x, p1.y, p1.z + 150)
        local topRight = vec3(p2.x, p2.y, p2.z + 150)

        local color = {r = 121, g = 34, b = 227, a = 150}
        
        DrawPoly(bottomLeft, topLeft, bottomRight, color.r, color.g, color.b, color.a)
        DrawPoly(topLeft, topRight, bottomRight, color.r, color.g, color.b, color.a)
        DrawPoly(bottomRight, topRight, topLeft, color.r, color.g, color.b, color.a)
        DrawPoly(bottomRight, topLeft, bottomLeft, color.r, color.g, color.b, color.a)
    end

    function self:drawZone()
        for i = 1, #self.points do
            self.p1 = self.points[i]
            if i < #self.points then
                self.p2 = self.points[i+1]
                self:showPolygon()
            end
        end

        if #self.points > 2 then
            self.p1 = self.points[1]
            self.p2 = self.points[#self.points]
            self:showPolygon()
        end
    end

    function self:applyDamage()
        while not self.inzone and self.active do
            local hp = GetEntityHealth(self.ped)
            local armor = GetPedArmour(self.ped)
    
            if armor > 0 then
                self:applyDamageEffects()
                SetPedArmour(self.ped, math.max(armor - self.damageAmount, 0))
            elseif hp > 101 then
                self:applyDamageEffects()
                SetEntityHealth(self.ped, math.max(hp - self.damageAmount, 0))
            else
                if self.alive then
                    self:handleDeath()
                end
                break 
            end
    
            Wait(self.damageInterval)
        end
    
        self:clearDamageEffects()
    end    

    function self:applyDamageEffects()
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)
        SetTimecycleModifier("damage")
    end

    function self:clearDamageEffects()
        StopGameplayCamShaking(true)
        ClearTimecycleModifier()
    end

    function self:handleDeath()
        self.alive = false
        if self.active then
            local playerServerId = GetPlayerServerId(PlayerId())
            TriggerServerEvent('invasion_system:playerKilled', playerServerId)
        end
        self.active = false
    end

    function self:checkWeapon()
        local rules = self.settings.rules
        local current_weapon = GetSelectedPedWeapon(self.ped, true)
        
        if not current_weapon or GetHashKey(current_weapon) == -1466831040 then
            return
        end

        local function checkTeamWeapons(weapons)
            for _, weapon in pairs(weapons) do
                if GetHashKey(current_weapon) ~= GetHashKey(weapon) then
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weapon), true)
                    return true
                end
            end
            return false
        end

        if not checkTeamWeapons(rules.weaponsTeamOne) then
            checkTeamWeapons(rules.weaponsTeamTwo)
        end
    end

    if state.spectInvasion then
        CreateThread(function()
            while state.isInInvasion do
                self:drawZone()
                Wait(4)
            end
        end)
    else
        CreateThread(function()
            while state.isInInvasion do
                self:drawZone()
                self:checkWeapon()
                
                local inside = self:isPlayerInZone()
                
                if inside and not self.inzone then
                    self.inzone = true
                elseif not inside and self.inzone then
                    self.inzone = false
                    CreateThread(function()
                        self:applyDamage()
                    end)
                end
                
                Wait(1)
            end
            self.active = false
        end)
    end
end

clientAPI.syncZone = function(data)
    if type(data) == 'table' then
        zone:handle(data)
    end
end 