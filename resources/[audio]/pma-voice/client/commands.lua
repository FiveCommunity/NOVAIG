local wasProximityDisabledFromOverride = false
disableProximityCycle = false
RegisterCommand('setvoiceintent', function(source, args)
	if GetConvarInt('voice_allowSetIntent', 1) == 1 then
		local intent = args[1]
		if intent == 'speech' then
			MumbleSetAudioInputIntent(`speech`)
		elseif intent == 'music' then
			MumbleSetAudioInputIntent(`music`)
		end
		LocalPlayer.state:set('voiceIntent', intent, true)
	end
end)

-- TODO: Better implementation of this?
RegisterCommand('vol', function(_, args)
	if not args[1] then return end
	setVolume(tonumber(args[1]))
end)

exports('setAllowProximityCycleState', function(state)
	type_check({state, "boolean"})
	disableProximityCycle = state
end)

function setProximityState(proximityRange, isCustom)
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(proximityRange + 0.0)
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance = proximityRange,
		mode = isCustom and "Custom" or voiceModeData[2],
	}, true)
	sendUIMessage({
		-- JS expects this value to be - 1, "custom" voice is on the last index
		voiceMode = isCustom and #Cfg.voiceModes or mode - 1
	})
end

exports("overrideProximityRange", function(range, disableCycle)
	type_check({range, "number"})
	setProximityState(range, true)
	if disableCycle then
		disableProximityCycle = true
		wasProximityDisabledFromOverride = true
	end
end)

exports("clearProximityOverride", function()
	local voiceModeData = Cfg.voiceModes[mode]
	setProximityState(voiceModeData[1], false)
	if wasProximityDisabledFromOverride then
		disableProximityCycle = false
	end
end)

local inLocation = false
RegisterCommand('cycleproximity', function()
	-- Proximity is either disabled, or manually overwritten.
	if GetConvarInt('voice_enableProximityCycle', 1) ~= 1 or disableProximityCycle then return end
	if GetEntityHealth(PlayerPedId()) <= 105 then return end
	
	if not inLocation then
		local newMode = mode + 1

		-- If we're within the range of our voice modes, allow the increase, otherwise reset to the first state
		if newMode <= #Cfg.voiceModes then
			mode = newMode
		else
			mode = 1
		end

		setProximityState(Cfg.voiceModes[mode][1], false)
		TriggerEvent('pma-voice:setTalkingMode', mode)
	end
end, false)

if gameVersion == 'fivem' then
	RegisterKeyMapping('cycleproximity', 'Cycle Proximity', 'keyboard', GetConvar('voice_defaultCycle', 'HOME'))
end

function MutePlayer() 
	playerMuted = true
	LocalPlayer.state:set('proximity', {
		index = 0,
		distance = 0.1,
		mode = 'Muted',
	}, GetConvarInt('voice_syncData', 1) == 1)
	MumbleSetAudioInputDistance(0.1)
end
exports('MutePlayer', MutePlayer)
RegisterNetEvent('pma-voice:MutePlayer', MutePlayer)

function DesmutePlayer() 
	playerMuted = false
	local voiceModeData = Cfg.voiceModes[mode]
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance =  voiceModeData[1],
		mode = voiceModeData[2],
	}, GetConvarInt('voice_syncData', 1) == 1)
	MumbleSetAudioInputDistance(Cfg.voiceModes[mode][1])
end
exports('DesmutePlayer', DesmutePlayer)
RegisterNetEvent('pma-voice:DesmutePlayer', DesmutePlayer)
