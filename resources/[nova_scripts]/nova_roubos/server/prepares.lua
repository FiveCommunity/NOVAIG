vRP._prepare('lotusRoubos/addPoint','INSERT INTO lotus_roberry_points (preset, cds) VALUES (@preset, @cds)')
vRP._prepare('lotusRoubos/getLastCount','SELECT count FROM lotus_roberry_points ORDER BY count DESC LIMIT 1')
vRP._prepare('lotusRoubos/getPoint','SELECT * FROM lotus_roberry_points')
vRP._prepare('lotusRoubos/getPointCount','SELECT * FROM lotus_roberry_points WHERE count=@count')


vRP._prepare('lotusRoubos/getAllPresets','SELECT * FROM lotus_robbery_presets ORDER BY name ASC')
vRP._prepare('lotusRoubos/checkPreset','SELECT name FROM lotus_robbery_presets WHERE name = @name')
vRP._prepare('lotusRoubos/createPreset','INSERT IGNORE INTO lotus_robbery_presets (name, awarddarkmoney, awardmin, awardmax, minigame, animation, animationtime, projection, permission, items, iswanted, cooldown) VALUES (@name, @awarddarkmoney, @awardmin, @awardmax, @minigame, @animation, @animationtime, @projection, @permission, @items, @iswanted, @cooldown)')
vRP._prepare('lotusRoubos/deletePreset','DELETE IGNORE FROM lotus_robbery_presets WHERE name = @name')
vRP._prepare('lotusRoubos/getAllPresetsName','SELECT name FROM lotus_robbery_presets ORDER BY name ASC')
vRP._prepare('lotusRoubos/getPreset','SELECT * FROM lotus_robbery_presets WHERE name = @name LIMIT 1')
vRP._prepare('lotusRoubos/updatePreset','UPDATE IGNORE lotus_robbery_presets SET name = @name, awarddarkmoney = @awarddarkmoney, awardmin = @awardmin, awardmax = @awardmax, minigame = @minigame, animationtime = @animationtime,  animation = @animation, projection = @projection, permission = @permission, items = @items, iswanted = @iswanted, cooldown = @cooldown WHERE name = @last_name')
vRP._prepare('lotusRoubos/removePoint','DELETE FROM lotus_roberry_points WHERE count=@count')

vRP._prepare('lotusRoubos/addHistoric','INSERT IGNORE INTO lotus_robbery_history (name, winner, duration, killfeed, time) VALUES (@name, @winner, @duration, @killfeed, @time)')
vRP._prepare('lotusRoubos/getHistoricWithName','SELECT time FROM lotus_robbery_history WHERE name=@name ORDER BY time DESC LIMIT 1')
vRP._prepare('lotusRoubos/getHistoric','SELECT * FROM lotus_robbery_history ORDER BY time DESC LIMIT @limit OFFSET @offset')
