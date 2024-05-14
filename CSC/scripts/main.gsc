shield_practice_enable(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    if (newval === 2) {
        level notify("shield_practice_enable");
        ShieldLog("Shield Practice Enabled");
    }
    else {
        ShieldLog("Shield Practice Not Enabled: Setting Up fast_restart Keybind");
        level.patch_settings = ShieldFromJson("bo4_practice");
        thread keybind_set_model(GetUIModelForController(localclientnum), "fast_restart", level.patch_settings.keybinds.fast_restart);
    }
}

on_localplayer_spawned(localclientnum)
{
    level waittill("shield_practice_enable");
    level.patch_settings = ShieldFromJson("bo4_practice");
    start_settings = level.patch_settings.start_settings;
    keybinds = level.patch_settings.keybinds;
    controller_model = GetUIModelForController(localclientnum);

    thread setup_start_settings(controller_model, start_settings);
    thread keybind_set_model(controller_model, "fast_restart", keybinds.fast_restart);
    thread keybind_set_model(controller_model, "noclip_toggle", keybinds.noclip_toggle);
    thread keybind_set_model(controller_model, "camera_set_position", keybinds.camera_set_position);
    thread keybind_set_model(controller_model, "camera_toggle", keybinds.camera_toggle);
    thread keybind_set_model(controller_model, "godmode", keybinds.godmode);
    thread keybind_set_model(controller_model, "infinite_ammo", keybinds.infinite_ammo);

    model = GetUIModel(controller_model, "PatchEnabled");
    if (IsDefined(model)) {
        ShieldLog("Set Patch Enabled");
        SetUIModelValue(model, 1);
    }
}

setup_start_settings(controller_model, settings)
{
    if (IsDefined(settings.points) && IsInt(settings.points) && settings.points) {
        model = GetUIModel(controller_model, "ClientToServer.points");
        if (IsDefined(model)) {
            SetUIModelValue(model, settings.points);
        }
    }
    if (IsDefined(settings.specialist_level) && IsInt(settings.specialist_level) && settings.specialist_level) {
        model = GetUIModel(controller_model, "ClientToServer.specialist_level");
        if (IsDefined(model)) {
            SetUIModelValue(model, settings.specialist_level);
        }
    }
    n_bitmask = 0;
    if (IsDefined(settings.godmode) && IsInt(settings.godmode) && settings.godmode) {
        n_bitmask |= 1 << 0;
    }
    if (IsDefined(settings.infinite_ammo) && IsInt(settings.infinite_ammo) && settings.infinite_ammo) {
        n_bitmask |= 1 << 1;
    }
    if (IsDefined(settings.perkaholic) && IsInt(settings.perkaholic) && settings.perkaholic) {
        n_bitmask |= 1 << 2;
    }
    if (IsDefined(settings.perkslot_1) && IsInt(settings.perkslot_1) && settings.perkslot_1) {
        n_bitmask |= 1 << 3;
    }
    if (IsDefined(settings.perkslot_2) && IsInt(settings.perkslot_2) && settings.perkslot_2) {
        n_bitmask |= 1 << 4;
    }
    if (IsDefined(settings.perkslot_3) && IsInt(settings.perkslot_3) && settings.perkslot_3) {
        n_bitmask |= 1 << 5;
    }
    if (IsDefined(settings.perkslot_4) && IsInt(settings.perkslot_4) && settings.perkslot_4) {
        n_bitmask |= 1 << 6;
    }
    model = GetUIModel(controller_model, "ClientToServer.start_settings");
    if (IsDefined(model)) {
        SetUIModelValue(model, n_bitmask);
    }
}

keybind_set_model(controller_model, str_response, str_keybind)
{
    if (!IsDefined(str_keybind) || str_keybind == "") {
        return;
    }
    model = GetUIModel(controller_model, "ClientToServer.keybind_message");
    if (IsDefined(model)) {
        thread set_model_on_keypress(model, 1, str_response, str_keybind);
    }
}