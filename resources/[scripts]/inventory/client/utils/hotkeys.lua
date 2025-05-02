local HOTKEY_COOLDOWN = 0
CreateThread(function()
    for i = 1, 5 do
        RegisterCommand("hotkey_"..i,function() 
            if GetGameTimer() - HOTKEY_COOLDOWN < 500 then return end
            if LocalPlayer.state.pvp then return end
            HOTKEY_COOLDOWN = GetGameTimer();
            Remote._useItem(
                tostring(i),
                1
            )
        end, false)
        RegisterKeyMapping("hotkey_"..i, "Use item "..i, "keyboard", tostring(i))
    end
end)