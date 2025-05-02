vRP._prepare("bench/items/createTable", [[
    CREATE TABLE IF NOT EXISTS `bench_items` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `item` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
        `user_id` INT(11) NOT NULL DEFAULT '0',
        `machine` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
        `amount` INT(10) UNSIGNED NOT NULL DEFAULT '0',
        `value` INT(10) UNSIGNED NOT NULL DEFAULT '0',
        `createdAt` DATETIME NOT NULL DEFAULT current_timestamp(),
        PRIMARY KEY (`id`) USING BTREE
    )
    COLLATE='utf8mb4_general_ci'
    ENGINE=InnoDB;
]])

vRP._prepare("bench/log/createTable", [[
    CREATE TABLE IF NOT EXISTS `bench_logs` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `user_id` INT(11) NOT NULL DEFAULT '0',
        `machine` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
        `log` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
        `createdAt` DATETIME NOT NULL DEFAULT current_timestamp(),
        PRIMARY KEY (`id`) USING BTREE
    )
    COLLATE='utf8mb4_general_ci'
    ENGINE=InnoDB;
]])

vRP.prepare("bench/items/getMachineItems", [[
    SELECT * FROM bench_items WHERE machine = @machine ORDER BY id ASC
]])

vRP.prepare("bench/logs/getMachineLogs", [[
    SELECT log FROM bench_logs WHERE machine = @machine ORDER BY id ASC LIMIT 30
]])

vRP.prepare("bench/logs/add", [[
    INSERT INTO bench_logs(user_id, machine, log) VALUES(@user_id, @machine, @log)
]])

vRP.prepare("bench/items/getMachineItem", [[
    SELECT * FROM bench_items WHERE id = @id
]])


