local PROPMANAGER_WEBHOOK = "https://discord.com/api/webhooks/1313519503795294268/WxNLDZG371XMyCZn0yVnyaBMfk9VkiImbZm3OrT4VmAXixOw_3g5ELVGm_csbOmC__bP"

AddEventHandler("likizao:PropManager:DeleteEntitys", function(user_id, entityArr, isAllEntities)
    PerformHttpRequest(PROPMANAGER_WEBHOOK, function(err, text, headers)
    end, 'POST', json.encode({
        content = "```ini\n[PropManager]\n[USER_ID]: "..user_id.."\n[QTD_ENTIDADES]: "..#entityArr.."\n[DELETOU EM MASSA]: "..(isAllEntities and "SIM" or "NAO").."\n```"
    }), {
        ['Content-Type'] = 'application/json'
    })
end)