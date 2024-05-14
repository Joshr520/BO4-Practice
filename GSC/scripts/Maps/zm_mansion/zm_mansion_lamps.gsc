zm_mansion_lamps_setup()
{
    thread zombie_open_sesame();
    zm_sq::start(#"hash_559b7237b8acece2");
    zm_sq::start(#"hash_578d0d7709a00e6e");
    zm_sq::start(#"zm_mansion_triad");
    level flag::set(#"gazed_greenhouse");
    level flag::set("bile_collected");
    level notify(#"ww_lvl2_crafted");

    foreach (player in GetPlayers()) {
        player.score = 5000;
        foreach (weapon in player GetWeaponsListPrimaries()) {
            player TakeWeapon(weapon);
        }
        player zm_weapons::weapon_give(level.var_6fe89212);
        player zm_weapons::weapon_give(GetWeapon("smg_fastfire_t8"));
        player zm_utility::function_28ee38f4(GetWeapon("smg_fastfire_t8"), 0, 1);
        player zm_weapons::weapon_give(GetWeapon("zhield_dw"));
        player GadgetPowerSet(level.var_a53a05b5, 100);
        player SetEverHadWeaponAll(1);
        player SetOrigin((4270, -140, -440));
        foreach (n_slot, str_perk in player.var_c27f1e90) {
            if (str_perk == "specialty_staminup") {
                player thread zm_perks::function_9bdf581f(str_perk, n_slot);
                break;
            }
        }

        wait 6;

        goto_round(9);
    }
}

greenhouse_lockdown_step_4_lamps(skip_step)
{
    level zm_ui_inventory::function_7df6bb60(#"hash_7b00684a8b212f70", 1);
    level thread function_c888f1f4();
    level thread [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_1be5e603 ]]();
    level flag::wait_till(#"house_defend");
    level flag::set(#"hash_b240a9137ecc6f9");
}