init_box_patch()
{
    box_settings = ShieldFromJson("box_settings");
    if (!IsDefined(box_settings) || !box_settings.enabled) {
        ShieldLog("Box Patch Not Enabled/Incorrect Settings");
        return;
    }

    level.a_forced_box_weapons = [];
    level.n_forced_box_index = 0;
    foreach (str_weapon in box_settings.box_settings.weapon_order) {
        if (str_weapon == "hash_7a42b57be462143f") {
            str_weapon = #"hash_7a42b57be462143f";
        }
        else if (str_weapon == "hash_138efe2bb30be63c") {
            str_weapon = #"hash_138efe2bb30be63c";
        }
        w_weapon = GetWeapon(str_weapon);
        if (w_weapon == level.weaponnone) {
            ShieldLog("Invalid Weapon Name");
            continue;
        }

        level.a_forced_box_weapons[level.a_forced_box_weapons.size] = w_weapon;
    }

    while (!level flag::exists("all_players_connected")) {
        wait 0.5;
    }
    level flag::wait_till("all_players_connected");

    init_player_box_override(1, box_settings.box_settings.player_overrides.player_1);
    init_player_box_override(2, box_settings.box_settings.player_overrides.player_2);
    init_player_box_override(3, box_settings.box_settings.player_overrides.player_3);
    init_player_box_override(4, box_settings.box_settings.player_overrides.player_4);

    level.oldcustomrandomweaponweights = level.customrandomweaponweights;
    level.customrandomweaponweights = &custom_box_odds;

    if (util::get_map_name() == "zm_towers") {
        while (!level flag::exists(#"hash_77ff9a8101ea687b")) {
            wait 0.5;
        }
        level flag::wait_till(#"hash_77ff9a8101ea687b");
        array::thread_all(level.chests, &towers_box_reset);
    }
    else if (util::get_map_name() == "zm_zodt8") {
        thread zodt8_box_reset();
    }
}

init_player_box_override(n_character_slot, player_settings)
{
    if (!player_settings.weapon_order.size) {
        return;
    }

    player_name = player_settings.player_name;
    e_player = undefined;
    if (IsDefined(player_name) && player_name != "") {
        e_player = get_player_by_name(player_name);
    }
    else if (!IsDefined(e_player)) {
        e_player = get_player_by_character_slot(n_character_slot);
        if (IsDefined(e_player) && IsDefined(e_player.a_forced_box_weapons_override)) {
            ShieldLog("Player Box Override Already Defined");
            return;
        }
    }
    if (!IsDefined(e_player)) {
        ShieldLog("Player Box Override Failed");
        return;
    }

    e_player.a_forced_box_weapons_override = [];
    e_player.n_forced_box_index_override = 0;

    foreach (str_weapon in player_settings.weapon_order) {
        if (str_weapon == "hash_7a42b57be462143f") {
            str_weapon = #"hash_7a42b57be462143f";
        }
        else if (str_weapon == "hash_138efe2bb30be63c") {
            str_weapon = #"hash_138efe2bb30be63c";
        }
        w_weapon = GetWeapon(str_weapon);
        if (w_weapon == level.weaponnone) {
            ShieldLog("Invalid Weapon Name");
            continue;
        }

        e_player.a_forced_box_weapons_override[e_player.a_forced_box_weapons_override.size] = w_weapon;
    }
}

custom_box_odds(a_weapons)
{
    if (IsDefined(self.a_forced_box_weapons_override) && self.a_forced_box_weapons_override.size) {
        if (self.n_forced_box_index_override >= self.a_forced_box_weapons_override.size) {
            level.customrandomweaponweights = level.oldcustomrandomweaponweights;
            self.a_forced_box_weapons_override = undefined;
            self.n_forced_box_index_override = undefined;
            return IsDefined(level.customrandomweaponweights) ? self [[ level.customrandomweaponweights ]](a_weapons) : a_weapons;
        }
        ArrayInsert(a_weapons, self.a_forced_box_weapons_override[self.n_forced_box_index_override], 0);
        self.n_forced_box_index_override++;
        return a_weapons;
    }
    if (level.n_forced_box_index >= level.a_forced_box_weapons.size) {
        level.customrandomweaponweights = level.oldcustomrandomweaponweights;
        level.a_forced_box_weapons = undefined;
        level.n_forced_box_index = undefined;
        return IsDefined(level.customrandomweaponweights) ? self [[ level.customrandomweaponweights ]](a_weapons) : a_weapons;
    }
    ArrayInsert(a_weapons, level.a_forced_box_weapons[level.n_forced_box_index], 0);
    level.n_forced_box_index++;
    return a_weapons;
}

towers_box_reset()
{
    level endon("towers_box_reset");
    for (;;) {
        self waittill(#"chest_accessed");
        level.customrandomweaponweights = &custom_box_odds;
        level notify("towers_box_reset");
    }
}

zodt8_box_reset()
{
    for (;;) {
        while (level.var_2e1644f2 !== 1) {
            waitframe(1);
        }
        while (IsDefined(level.customrandomweaponweights)) {
            waitframe(1);
        }
        level.customrandomweaponweights = &custom_box_odds;
    }
}