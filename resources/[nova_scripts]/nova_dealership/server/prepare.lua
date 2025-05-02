Prepare = {
    ['bm_module/dealership/createTable'] = "CREATE TABLE IF NOT EXISTS `bm_dealership` ( `vehicle` varchar(50) NOT NULL, `stock` int(11) DEFAULT 0, PRIMARY KEY (`vehicle`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
    ['bm_module/dealership/getVehicles'] = "SELECT * FROM bm_dealership",
    ['bm_module/dealership/updateStock'] = "UPDATE bm_dealership SET stock = @stock WHERE vehicle = @vehicle",
    ['bm_module/dealership/removeVehicle'] = "DELETE FROM bm_dealership WHERE vehicle = @vehicle",
    ['bm_module/dealership/addVehicle'] = "REPLACE INTO bm_dealership(vehicle,stock) VALUES(@vehicle,@stock)",
    ['bm_module/dealership/createNewVehicleStock'] = "UPDATE bm_dealership SET stock = @stock WHERE vehicle = @vehicle",
    ['bm_module/dealership/getVehicle'] = "SELECT veiculo FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @vehicle",
    ['bm_module/dealership/totalVehicles'] = "SELECT COUNT(veiculo) as qtd FROM vrp_user_veiculos WHERE user_id = @user_id",
    ['bm_module/dealership/addUserVehicle'] = "INSERT INTO vrp_user_veiculos(user_id,veiculo,ipva) VALUES(@user_id,@vehicle,@ipva)",
    ['bm_module/dealership/addUserVehicleTuning'] = "INSERT INTO vrp_user_veiculos(user_id,veiculo,ipva,tunagem) VALUES(@user_id,@vehicle,@ipva,@tunagem)",
    ['bm_module/dealership/removeUserVehicle'] = "DELETE FROM vrp_user_veiculos WHERE veiculo = @vehicle AND user_id = @user_id",
    ['bm_module/dealership/updateAmountSell'] = "UPDATE bm_dealership SET amountSell = @amountSell WHERE vehicle = @vehicle"
}