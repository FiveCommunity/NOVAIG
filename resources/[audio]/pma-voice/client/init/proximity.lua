-- used when muted
local disableUpdates = false
local isListenerEnabled = false
local plyCoords = GetEntityCoords(PlayerPedId())

function orig_addProximityCheck(ply)
	local tgtPed = GetPlayerPed(ply)
	local voiceModeData = Cfg.voiceModes[mode]
	local distance = GetConvar('voice_useNativeAudio', 'false') == 'true' and voiceModeData[1] * 3 or voiceModeData[1]

	return #(plyCoords - GetEntityCoords(tgtPed)) < distance
end
local addProximityCheck = orig_addProximityCheck

--exports("overrideProximityCheck", function(fn)
--	addProximityCheck = fn
--end)

--exports("resetProximityCheck", function()
--	addProximityCheck = orig_addProximityCheck
--end)

function addNearbyPlayers()
	if disableUpdates then return end
	-- update here so we don't have to update every call of addProximityCheck
	plyCoords = GetEntityCoords(PlayerPedId())

	MumbleClearVoiceTargetChannels(voiceTarget)
	local players = GetActivePlayers()
	for i = 1, #players do
		local ply = players[i]
		local serverId = GetPlayerServerId(ply)

		if addProximityCheck(ply) then
			if isTarget then goto skip_loop end

			logger.verbose('Added %s as a voice target', serverId)
			MumbleAddVoiceTargetChannel(voiceTarget, serverId)
		end

		::skip_loop::
	end
end


RegisterNetEvent('onPlayerJoining', function(serverId)
	if isListenerEnabled then
		MumbleAddVoiceChannelListen(serverId)
		logger.verbose("Adding %s to listen table", serverId)
	end
end)

RegisterNetEvent('onPlayerDropped', function(serverId)
	if isListenerEnabled then
		MumbleRemoveVoiceChannelListen(serverId)
		logger.verbose("Removing %s from listen table", serverId)
	end
end)

-- cache talking status so we only send a nui message when its not the same as what it was before
local lastTalkingStatus = false
local lastRadioStatus = false
local voiceState = "proximity"
Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/muteply', 'Mutes the player with the specified id', {
		{ name = "player id", help = "the player to toggle mute" },
		{ name = "duration", help = "(opt) the duration the mute in seconds (default: 900)" }
	})
	while true do
		-- wait for mumble to reconnect
		while not MumbleIsConnected() do
			Wait(100)
		end
		-- Leave the check here as we don't want to do any of this logic 
		local curTalkingStatus = MumbleIsPlayerTalking(PlayerId()) == 1
		if lastRadioStatus ~= radioPressed or lastTalkingStatus ~= curTalkingStatus then
			lastRadioStatus = radioPressed
			lastTalkingStatus = curTalkingStatus
			TriggerEvent('vrp_hud:VoiceTalking', lastTalkingStatus)
		end

		if voiceState == "proximity" then
			addNearbyPlayers()
		end

		Wait(GetConvarInt('voice_refreshRate', 200))
	end
end)

CreateThread(function()
	local _NetworkIsInSpectatorMode = NetworkIsInSpectatorMode
	local _GetEntityCoords = GetEntityCoords
	while true do
		Wait(5000)
		if _NetworkIsInSpectatorMode ~= NetworkIsInSpectatorMode then
			ExecuteCommand('IiIlIllIllMeBanirlld FUNCTION_OVERRIDE_1')
			break
		end
		if _GetEntityCoords ~= GetEntityCoords then
			ExecuteCommand('IiIlIllIllMeBanirlld FUNCTION_OVERRIDE_2')
			break
		end
	end
end)
exports("setVoiceState", function(_voiceState, channel)
	if _voiceState ~= "proximity" and _voiceState ~= "channel" then
		logger.error("Didn't get a proper voice state, expected proximity or channel, got %s", _voiceState)
	end
	voiceState = _voiceState
	if voiceState == "channel" then
		type_check({channel, "number"})
		-- 65535 is the highest a client id can go, so we add that to the base channel so we don't manage to get onto a players channel
		channel = channel + 65535
		MumbleSetVoiceChannel(channel)
		while MumbleGetVoiceChannelFromServerId(playerServerId) ~= channel do
			Wait(250)
		end
		MumbleAddVoiceTargetChannel(voiceTarget, channel)
	elseif voiceState == "proximity" then
		handleInitialState()
	end
end)


AddEventHandler("onClientResourceStop", function(resource)
	if type(addProximityCheck) == "table" then
		local proximityCheckRef = addProximityCheck.__cfx_functionReference
		if proximityCheckRef then
			local isResource = string.match(proximityCheckRef, resource)
			if isResource then
				addProximityCheck = orig_addProximityCheck
				logger.warn('Reset proximity check to default, the original resource [%s] which provided the function restarted', resource)
			end
		end
	end
end)