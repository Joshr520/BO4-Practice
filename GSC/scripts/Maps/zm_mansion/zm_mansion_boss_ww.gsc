zm_mansion_boss_setup()
{
    foreach (player in GetPlayers()) {
        foreach (weapon in player GetWeaponsListPrimaries()) {
            player TakeWeapon(weapon);
        }
        player zm_weapons::weapon_give(GetWeapon("smg_fastfire_t8_upgraded"));
        player zm_utility::function_28ee38f4(GetWeapon("smg_fastfire_t8_upgraded"), 0, 1);
        player zm_weapons::weapon_give(level.var_7b9ca97a);
        player zm_weapons::weapon_give(GetWeapon("zhield_dw"));
        foreach (n_slot, str_perk in player.var_c27f1e90) {
            if (str_perk == "specialty_staminup") {
                player thread zm_perks::function_9bdf581f(str_perk, n_slot);
            }
            else if (str_perk == "specialty_awareness") {
                player thread zm_perks::function_cc24f525();
                break;
            }
        }
    }
    zm_sq::start("zm_mansion_ww");
    wait 1;
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
    
    thread monitor_boss_hud();
}

monitor_boss_hud()
{
    level endon(#"hash_480ab8b0d38942cc");
    while (!IsDefined(level.s_boss) || !IsDefined(level.s_boss.var_4944ec8) || !IsDefined(level.s_boss.var_57badb98)) {
        waitframe(1);
    }
    for (;;) {
        n_prev_health = level.s_boss.var_57badb98;
        level.s_boss.var_4944ec8 waittill("damage");
        while (level.s_boss.var_57badb98 == n_prev_health) {
            waitframe(1);
        }
        if (level.s_boss.var_57badb98 >= level.s_boss.var_c962047c) {
            LUINotifyEvent(#"boss_health_toggle", 1, 0);
        }
        else {
            LUINotifyEvent(#"boss_health_update", 2, Int(level.s_boss.var_c962047c - level.s_boss.var_57badb98), Int(level.s_boss.var_c962047c));
        }
    }
}