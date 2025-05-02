
fx_version "bodacious"
game "gta5"

author '[[Meliodax]] - o han é viado e quer chupar meu pinto.'

shared_scripts { "@vrp/lib/utils.lua", "src/config.lua" }

files {
    "ui/*",
    "ui/**/*",
    "ui/**/**/*",
	"data/*.meta",
	"data/**/*",
}

ui_page "ui/index.html"


client_scripts {
    "src/client.lua"
}

server_scripts {
    "src/server.lua",
}

data_file "DLC_ITYP_REQUEST" "mt_boxpreta.ytyp"
data_file "WEAPONCOMPONENTSINFO_FILE" "data/weaponcomponents.meta"
data_file "WEAPON_METADATA_FILE" "data/weaponarchetypes.meta"

data_file "FIVEM_LOVES_YOU_4B38E96CC036038F" "data/metas/events.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_assaultrifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponcompactrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapongusenberg.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponheavypistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponmachinepistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponminismg.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_pistol_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponrevolver.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponsnspistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_snspistol_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponvintagepistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponbattleaxe.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponbottle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponflashlight.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponhatchet.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponknuckle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponmachete.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponpoolcue.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponstonehatchet.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponwrench.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponmusket.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponbullpuprifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_bullpuprifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_carbinerifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_pumpshotgun_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_smg_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_specialcarbine_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weaponspecialcarbine.meta"           
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_revolver_mk2.meta"           
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapon_tacticalrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/metas/weapons_heavyrifle.meta"