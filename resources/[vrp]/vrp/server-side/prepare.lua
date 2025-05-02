-- QUERYS GERAL
vRP.prepare("vRP/create_user","INSERT INTO vrp_users(whitelist) VALUES(false); SELECT LAST_INSERT_ID() AS id")
vRP.prepare("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/get_all_licenses","SELECT * FROM vrp_user_ids WHERE user_id = @user_id")
vRP.prepare("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
vRP.prepare("vRP/del_srvdata","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP.prepare("vRP/get_whitelisted","SELECT whitelist FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelisted","UPDATE vrp_users SET whitelist = @whitelist WHERE id = @user_id")
vRP.prepare("vRP/set_last_login","UPDATE vrp_users SET ultimo_login = @ultimo_login, ip = @ip WHERE id = @user_id")

-- BANS
vRP.prepare("mirtin/getAllBans","SELECT * FROM mirtin_bans WHERE time < UNIX_TIMESTAMP() AND time > 0")
vRP.prepare("mirtin/getUserBanned","SELECT * FROM mirtin_bans WHERE user_id = @user_id")
vRP.prepare("mirtin/insertBanned","INSERT IGNORE INTO mirtin_bans(user_id,motivo,desbanimento,banimento,time, hwid) VALUES(@user_id,@motivo,@desbanimento,@banimento,@time, @hwid)")
vRP.prepare("mirtin/addToken","INSERT IGNORE INTO mirtin_bans_hwid(id,token) VALUES(@user_id,@token)")
vRP.prepare("mirtin/select_hwid", "SELECT * FROM mirtin_bans_hwid mhb LEFT JOIN mirtin_bans mh ON (mh.user_id = mhb.id) WHERE mhb.token = @token AND hwid = '1'")
vRP.prepare("mirtin/removeBanned", "DELETE FROM mirtin_bans WHERE user_id = @user_id")
vRP.prepare("mirtin/createBanDB",[[ CREATE TABLE IF NOT EXISTS `mirtin_bans` ( `user_id` int(11) NOT NULL, `motivo` text NOT NULL, `banimento` tinytext NOT NULL, `desbanimento` tinytext NOT NULL, `time` int(11) NOT NULL, `hwid` int(11) NOT NULL, PRIMARY KEY (`user_id`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ]])
vRP.prepare("mirtin/createBanDBHWID",[[ CREATE TABLE IF NOT EXISTS `mirtin_bans_hwid` ( `token` varchar(120) NOT NULL, `id` int(11) NOT NULL, PRIMARY KEY (`token`), KEY `id` (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ]])
vRP.prepare("getUserId", "SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")


-- CREATE CHARACTER
vRP.prepare("vRP/get_all_users","SELECT * FROM vrp_users WHERE id = @id")
vRP.prepare("vRP/get_controller","SELECT controller FROM vrp_users_infos WHERE user_id = @user_id")
vRP.prepare("vRP/set_controller","UPDATE vrp_users_infos SET controller = @controller, rosto = @rosto, roupas = @roupas WHERE user_id = @user_id")
vRP.prepare("vRP/get_rosto","SELECT rosto FROM vrp_users_infos WHERE user_id = @user_id")

-- USER IDENTITIES
vRP.prepare("vRP/update_multas","UPDATE vrp_user_identities SET multas = @multas WHERE user_id = @user_id")
vRP.prepare("vRP/update_banco","UPDATE vrp_user_identities SET banco = @banco WHERE user_id = @user_id")
vRP.prepare("vRP/update_makapoints","UPDATE vrp_user_identities SET makapoints = @makapoints WHERE user_id = @user_id")

-- USER INFOS
vRP.prepare("vRP/init_users_infos","INSERT IGNORE INTO vrp_users_infos(user_id) VALUES(@user_id)")
vRP.prepare("vRP/get_users_infos","SELECT roupas,tattos,rosto,controller FROM vrp_users_infos WHERE user_id = @user_id")
vRP.prepare("apparence/rosto", "UPDATE vrp_users_infos SET rosto = @rosto WHERE user_id = @user_id")
vRP.prepare("apparence/roupas", "UPDATE vrp_users_infos SET roupas = @roupas WHERE user_id = @user_id")
vRP.prepare("apparence/tattos", "UPDATE vrp_users_infos SET tattos = @tattos WHERE user_id = @user_id")

-- PORTA MALAS
vRP.prepare("vRP/get_portaMalas","SELECT portamalas FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/update_portaMalas","UPDATE vrp_user_veiculos SET portamalas = @portamalas WHERE user_id = @user_id AND veiculo = @veiculo")

-- TUNAGENS
vRP.prepare("vRP/update_tuning","UPDATE vrp_user_veiculos SET tunagem = @tunagem WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/update_nitro","UPDATE vrp_user_veiculos SET nitro = @nitro WHERE user_id = @user_id AND veiculo = @veiculo")

-- CONCESSIONARIA
vRP.prepare("vRP/inserir_veh","INSERT IGNORE INTO vrp_user_veiculos(user_id,veiculo,ipva, expired) VALUES(@user_id,@veiculo,@ipva,@expired)")
vRP.prepare("vRP/delete_vehicle","DELETE FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/get_stock","SELECT COUNT(veiculo) as quantidade FROM vrp_user_veiculos WHERE veiculo = @veiculo")
vRP.prepare("vRP/selecionar_veiculos","SELECT * FROM vrp_user_veiculos")

-- GARAGEM
vRP.prepare("vRP/getAllVehicles","SELECT * FROM vrp_user_veiculos")
vRP.prepare("vRP/get_Veiculos","SELECT * FROM vrp_user_veiculos WHERE user_id = @user_id")
vRP.prepare("vRP/update_veiculo_status","UPDATE vrp_user_veiculos SET motor = @motor, lataria = @lataria, gasolina = @gasolina WHERE user_id = @user_id and veiculo = @veiculo")
vRP.prepare("vRP/count_veiculos","SELECT COUNT(veiculo) as quantidade FROM vrp_user_veiculos WHERE user_id = @user_id")
vRP.prepare("vRP/get_nitro","SELECT nitro FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/get_tunagem","SELECT tunagem FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/get_veiculos_status","SELECT * FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/set_status","UPDATE vrp_user_veiculos SET status = @status WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/set_ipva","UPDATE vrp_user_veiculos SET ipva = @ipva WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/update_owner_vehicle","UPDATE vrp_user_veiculos SET user_id = @nuser_id WHERE user_id = @user_id AND veiculo = @veiculo")

-- INVENTARIO
vRP.prepare("vRP/inv_deltmpchest", "DELETE FROM vrp_srv_data WHERE `dkey` LIKE '%tmpChest:%'")

-- VIPS
vRP.prepare("vRP/select_bonus","SELECT bonus FROM vrp_users_infos WHERE user_id = @user_id")
vRP.prepare("vRP/update_bonus","UPDATE vrp_users_infos SET bonus = @bonus WHERE user_id = @user_id")
vRP.prepare("vRP/getNumber","SELECT telefone FROM vrp_user_identities WHERE telefone = @telefone")
vRP.prepare("vRP/getRegistro","SELECT registro FROM vrp_user_identities WHERE registro = @registro")
vRP.prepare("vRP/update_number","UPDATE vrp_user_identities SET telefone = @telefone WHERE user_id = @user_id")
vRP.prepare("vRP/update_registro","UPDATE vrp_user_identities SET registro = @registro WHERE user_id = @user_id")
vRP.prepare("vRP/getPlate","SELECT placa FROM vrp_user_veiculos WHERE placa = @placa")
vRP.prepare("vRP/update_plate","UPDATE vrp_user_veiculos SET placa = @placa WHERE user_id = @user_id AND veiculo = @veiculo")
vRP.prepare("vRP/update_garagem","UPDATE vrp_users_infos SET garagem = @garagem WHERE user_id = @user_id")

-- FICHA CRIMINAL
vRP.prepare("vRP/add_criminal","UPDATE vrp_user_identities SET criminal = @criminal WHERE user_id = @user_id")
vRP.prepare("vRP/add_multa","UPDATE vrp_user_identities SET multas = @multas WHERE user_id = @user_id")


-- RACES
vRP.prepare("races/checkResult","SELECT * FROM lotus_races WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/requestRanking","SELECT * FROM lotus_races WHERE raceid = @raceid ORDER BY points ASC LIMIT 5")
vRP.prepare("races/updateRecords","UPDATE lotus_races SET points = @points, vehicle = @vehicle WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/insertRecords","INSERT INTO lotus_races(raceid,user_id,name,vehicle,points) VALUES(@raceid,@user_id,@name,@vehicle,@points)")

