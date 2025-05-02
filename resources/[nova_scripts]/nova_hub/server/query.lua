local Querys = {
    ["lotus_hub/getRanking"] = "SELECT * FROM lotus_hub",

    ["lotus_hub/createRanking"] = [[
        INSERT INTO lotus_hub (user_id, name, calls, hours, stars, totalstars, service) 
        VALUES (@user_id, @name, @calls, @hours, @stars, @totalstars, @service)
        ON DUPLICATE KEY UPDATE 
        name = VALUES(name),
        calls = VALUES(calls),
        hours = VALUES(hours),
        stars = VALUES(stars),
        totalstars = VALUES(totalstars),
        service = VALUES(service)
    ]],

    ["lotus_hub/updateRanking"] = [[
        UPDATE lotus_hub SET 
        calls = @calls, 
        hours = @hours, 
        stars = @stars, 
        totalstars = @totalstars 
        WHERE user_id = @user_id and service = @service
    ]],

    ["lotus_hub/createTable"] = [[
        CREATE TABLE IF NOT EXISTS `lotus_hub` (
            `user_id` int(11) NOT NULL,
            `service` varchar(150) NOT NULL DEFAULT '',
            `name` varchar(150) NOT NULL DEFAULT '',
            `calls` int(11) NOT NULL DEFAULT 0,
            `hours` float NOT NULL DEFAULT 0,
            `stars` float NOT NULL DEFAULT 0,
            `totalstars` float DEFAULT 0
        )
    ]],

    ["lotus_hub/deleteRanking"] = [[
        DELETE FROM lotus_hub WHERE service = @service
    ]],

    ["lotus_hub/selectLastId"] = [[
        SELECT user_id FROM lotus_hub ORDER BY user_id DESC LIMIT 1
    ]]
}

CreateThread(function()
    for queryName, query in pairs(Querys) do
        vRP.prepare(queryName, query)
    end
end)