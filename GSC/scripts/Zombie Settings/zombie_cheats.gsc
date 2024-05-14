craft_parts()
{
    a_e_items = GetItemArray();
    foreach (e_item in a_e_items) {
        w_item = e_item.item;
        if (IsDefined(w_item) && IsDefined(w_item.craftitem) && w_item.craftitem) {
            zm_items::player_pick_up(self, w_item);
            e_item delete();
        }
    }

    switch (level.script) {
        case "zm_mansion": {
            foreach (a_s_crafting in level.var_4fe2f84d) {
                s_crafting = a_s_crafting[1];
                if (IsArray(s_crafting.craftfoundry.blueprints)) {
                    foreach (j, s_blueprint in s_crafting.craftfoundry.blueprints) {
                        if (s_blueprint.name === "zblueprint_shield_spectral_shield") {
                            s_crafting.blueprint = s_blueprint;
                            zm_unitrigger::unregister_unitrigger(s_crafting);
                            s_crafting zm_crafting::reset_table();
                            s_crafting zm_crafting::function_a187b293();
                            break;
                        }
                    }
                }
                break;
            }
            break;
        }
    }
}

zombie_open_sesame() {
    setdvar(#"zombie_unlock_all", 1);
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 1);
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (IsDefined(trig.script_int)) {
            level flag::set("power_on" + trig.script_int);
            level clientfield::set("zombie_power_on", trig.script_int + 1);
        }
    }
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!(IsDefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (IsDefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (IsDefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    wait(1);
    setdvar(#"zombie_unlock_all", 0);

    level notify(#"hash_3e80d503318a5674", {#player:level.players[0]});

    switch (level.script) {
        case "zm_mansion": {
            level flag::set("open_pap_dev");
            level flag::set("unlock_pap_gate");
            level thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_94fc7512 ]]("main_hall");
            level thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_94fc7512 ]]("library");
            level thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_94fc7512 ]]("greenhouse");
            scene::add_scene_func(#"p8_fxanim_zm_man_ooze_clump_bundle", @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_93e11617, "trails", level.players[0]);
            level thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_94fc7512 ]]();
        }
    }
}

goto_round(target_round)
{
    level.zombie_total = 0;
    level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), target_round - 1);
    zm_round_logic::set_round_number(target_round - 1);
    level notify(#"kill_round");
    level zm_utility::function_9ad5aeb1(0, 1, 0, 0, 1);
}