----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SET GPS ROUTE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE TAZER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local tazertime = false
Citizen.CreateThread(function()
	while true do
		local time = 500
		local ped = PlayerPedId()
        if IsPedBeingStunned(ped) then
            time = 5
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end

        if IsPedBeingStunned(ped) and not tazertime then
            time = 5
			tazertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
			TriggerEvent("ragdoll:ChangeStatus", tazertime)
        elseif not IsPedBeingStunned(ped) and tazertime then
            time = 5
			tazertime = false
			TriggerEvent("ragdoll:ChangeStatus", tazertime)
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
        end

        Citizen.Wait(time)
	end
end)