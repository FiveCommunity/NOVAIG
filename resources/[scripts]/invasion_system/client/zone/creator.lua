creator = {}
creator.__index = creator -- metamethod
storage = {}

function creator:new()
    local self     = setmetatable({}, creator)

    print(json.encode(self))
    self.points    = {}
    self.inCreate  = true
    self.ped       = PlayerPedId()

    function self:drawAssistant()
        drawText(('~b~[E]~w~ - PARA POSICIONAR ~b~%s~w~ º PONTO'):format(#self.points),4,0.10,0.8,0.50,255,255,255,180,true)
        drawText('~b~[F]~w~ PARA REMOVER ULTIMO PONTO', 4, 0.10, 0.83, 0.50, 100, 149, 237, 180,true)
        drawText('~b~[BACKSPACE]~w~ PARA CANCELAR.', 4, 0.10, 0.86, 0.50, 100, 149, 237, 180,true)
        drawText('~b~ENTER~w~ PARA CRIAR.', 4, 0.10, 0.89, 0.50, 100, 149, 237, 180,true)
        DrawLine(self.coords, self.rayCoords, 255, 0, 0, 255)
        DrawLine(self.coords, self.rayCoords, 255, 0, 0, 255)
        DrawMarker(28,self.rayCoords.x,self.rayCoords.y,self.rayCoords.z,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.2,0.2,255,0,0,255,false,false,0,true,false,false,false)
    end
    function self:showPreviewPolygon()
        local p1          = self.p1
        local p2          = self.p2
        local bottomLeft  = vec3(p1[1], p1[2], p1[3] - 150)
        local bottomRight = vec3(p2[1], p2[2], p2[3] - 150)
        local topLeft     = vec3(p1[1], p1[2], p1[3] + 150)
        local topRight    = vec3(p2[1], p2[2], p2[3] + 150)

        DrawPoly(bottomLeft, topLeft, bottomRight, 100,149,237, 70)
        DrawPoly(topLeft, topRight, bottomRight, 100,149,237, 70)
        DrawPoly(bottomRight, topRight, topLeft, 100,149,237, 70)
        DrawPoly(bottomRight, topLeft, bottomLeft, 100,149,237, 70)
    end
    function self:drawPreview(data)
        local points in self

        for i = 1, #points do
            self.p1 = points[i]
            if i < #points then
                self.p2 = points[i+1]
                self:showPreviewPolygon()
            end
        end

        if #points > 2 then
            self.p1 = points[1]
            self.p2 = points[#points]
            self:showPreviewPolygon()
        end
    end

    while self.inCreate do
        local previewZone = function()
            local hit, entity, rayCoords = rayCastCamera()
            self.coords                  = GetEntityCoords(self.ped)
            self.rayCoords               = rayCoords
            self:drawAssistant()

            if IsControlJustPressed(0, 38) then -- PRESSED [E]
                self.points[#self.points + 1] = self.rayCoords
                TriggerEvent('Notify', 'sucesso', 'Você adicionou um ponto de coordenada.')
            end

            if IsControlJustPressed(0, 75) and #self.points > 0 then -- PRESSED [F]
                self.points[#self.points] = nil
                TriggerEvent('Notify', 'importante', 'Você removeu o ultimo ponto de coordenada.')
            end

            if IsControlJustPressed(0, 177) then -- PRESSED BACKSPACE
                self.inCreate = false

                serverAPI.cancelInvasion()
                
                return TriggerEvent('Notify', 'negado', 'Você cancelou a criação da zona.')
            end

            if IsControlJustPressed(0, 201) then -- PRESSED ENTER
                self.inCreate = false

                TriggerEvent('Notify', 'sucesso', 'Você criou essa zona com sucesso.')

                return serverAPI.resolveNewZone(self)
            end

            if (#self.points > 0) then -- draw preview poly
                self:drawPreview()
            end
        end
        CreateThread(previewZone)
        Wait(0)
    end

    return self
end
