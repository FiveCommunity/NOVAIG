vRP._prepare("bm_module/garages/getAllUserVehicles", "SELECT user_id,veiculo,status,motor,lataria,gasolina,ipva,tunagem,favorite FROM vrp_user_veiculos WHERE user_id = @user_id")
vRP._prepare("bm_module/garages/getSpawnVehInfo", "SELECT veiculo,motor,lataria,gasolina,tunagem FROM vrp_user_veiculos WHERE veiculo = @veiculo AND user_id = @user_id")
vRP._prepare("bm_module/garages/getStatus", "SELECT status,ipva FROM vrp_user_veiculos WHERE veiculo = @veiculo AND user_id = @user_id")
vRP._prepare("bm_module/garages/updateFavorite", "UPDATE vrp_user_veiculos SET favorite = @favorite WHERE user_id = @user_id AND veiculo = @veiculo")
vRP._prepare("bm_module/garages/updateStatus", "UPDATE vrp_user_veiculos SET status = @status WHERE user_id = @user_id AND veiculo = @veiculo")
vRP._prepare("bm_module/garages/updateIpva", "UPDATE vrp_user_veiculos SET ipva = @ipva WHERE user_id = @user_id AND veiculo = @veiculo")
vRP._prepare("bm_module/garages/updateVehicleInfos", "UPDATE vrp_user_veiculos SET motor = @motor, lataria = @lataria, gasolina = @gasolina WHERE user_id = @user_id AND veiculo = @veiculo")
vRP._prepare("bm_module/garages/updateOwnerVehicle", "UPDATE vrp_user_veiculos SET user_id = @new_owner, portamalas = @portamalas WHERE user_id = @user_id AND veiculo = @veiculo")
