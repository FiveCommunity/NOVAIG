local cfg = {}

cfg.static_menu_types = {
    ["admin_expedientes"] = {
        title = "Admin Expedientes",
        permissions = {"perm.ptr.staff"}
    },
}

cfg.static_menus = {
    {"admin_expedientes", -545.27,-204.24,38.22}
}

return cfg
