zm_mansion_lockdown_setup(n_lockdown)
{
    thread zombie_open_sesame();
    zm_sq::start(#"hash_559b7237b8acece2");
    zm_sq::start(#"hash_578d0d7709a00e6e");
    zm_sq::start(#"zm_mansion_triad");

    foreach (player in GetPlayers()) {
        switch (n_lockdown) {
            case 1: {
                player SetOrigin((4270, -140, -440));
                break;
            }
            case 2: {
                player SetOrigin((-4180, 470, 110));
                break;
            }
            case 3: {
                player SetOrigin((-30, 5630, -780));
                break;
            }
            default: {
                break;
            }
        }
        if (n_lockdown == 3) {
            player.score = 10000;
        }
        else {
            player.score = 5000;
        }
        foreach (weapon in player GetWeaponsListPrimaries()) {
            player TakeWeapon(weapon);
        }
        if (n_lockdown == 1) {
            player zm_weapons::weapon_give(level.var_6fe89212);
        }
        else {
            player zm_weapons::weapon_give(level.var_7b9ca97a);
        }
        player zm_weapons::weapon_give(GetWeapon("smg_fastfire_t8"));
        player zm_utility::function_28ee38f4(GetWeapon("smg_fastfire_t8"), 0, 1);
        player zm_weapons::weapon_give(GetWeapon("zhield_dw"));
        player GadgetPowerSet(level.var_a53a05b5, 100);
        player SetEverHadWeaponAll(1);
        foreach (n_slot, str_perk in player.var_c27f1e90) {
            if (str_perk == "specialty_staminup") {
                player thread zm_perks::function_9bdf581f(str_perk, n_slot);
                break;
            }
        }
    }

    wait 6;
    
    if (n_lockdown == 1) {
        goto_round(9);
    }
    else {
        goto_round(12);
    }
}

greenhouse_lockdown_step_4(skip_step)
{
    level zm_ui_inventory::function_7df6bb60(#"hash_7b00684a8b212f70", 1);
    level thread function_c888f1f4();
    level thread [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_1be5e603 ]]();
    b_enemy_markers = level.patch_settings.settings.zm_mansion.lockdowns.enemy_markers === 1;
    if (b_enemy_markers) {
        thread wait_transform_add_obj();
    }
    if (!skip_step) {
        level flag::wait_till(#"house_defend");
        IPrintLnBold("Lockdown Started");
        level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
        level flag::clear(#"spawn_zombies");
        level flag::clear(#"zombie_drop_powerups");
        [[ @mansion_util<scripts\zm\zm_mansion_util.gsc>::function_45ac4bb8 ]]();
        level thread [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_f3668a9 ]]();
        level thread [[ @mansion_util<scripts\zm\zm_mansion_util.gsc>::function_bb613572 ]]([[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_a7bed514 ]](), #"hash_b240a9137ecc6f9");
        greenhouse_wave_1(b_enemy_markers);
        IPrintLnBold("Next Wave");
        level notify("release_objs");
        greenhouse_wave_3(b_enemy_markers);
        a_players = util::get_active_players();
        e_player_random = array::random(a_players);
        if (isalive(e_player_random)) {
            e_player_random thread zm_vo::function_a2bd5a0c(#"hash_5927981205a122fc", 0, 1);
        }
        level flag::wait_till(#"greenhouse_open");
    }
}

function_c888f1f4() {
    level endon(#"greenhouse_open");
    mdl_stone = getent("stone_obs", "targetname");
    mdl_stone show();
    mdl_stone clientfield::set("" + #"force_stream_model", 1);
    mdl_door = getent("mdl_telescope_base_door", "targetname");
    s_moveto = struct::get(mdl_door.target);
    mdl_door moveto(s_moveto.origin, 3, 0.1, 1.5);
    mdl_door playsound(#"hash_34b16f03c4ce4b97");
    mdl_door waittill(#"movedone");
    mdl_door moveto(s_moveto.origin - vectorscale((0, 0, 1), 64), 3);
    mdl_door playsound(#"hash_34b17003c4ce4d4a");
    mdl_door waittill(#"movedone");
    var_47323b73 = mdl_stone zm_unitrigger::create(undefined, 128);
    var_47323b73.v_start = mdl_stone.angles;
    mdl_stone thread [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_31e641f5 ]]();
}

greenhouse_wave_1(b_enemy_markers) {
    level endon(#"hash_b240a9137ecc6f9");
    level flag::wait_till(#"house_defend");
    wait(2);
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_num = 16;
        n_current = 9;
        break;
    case 2:
        n_num = 22;
        n_current = 13;
        break;
    case 3:
        n_num = 27;
        n_current = 17;
        break;
    case 4:
        n_num = 32;
        n_current = 20;
        break;
    }
    level.var_e12e0420 = 0;
    level.var_84b2907f = @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_a9b81878;
    a_s_locs = array::randomize(struct::get_array("greenhouse_bat"));
    x = 0;
    level flag::set(#"hash_29b12646045186fa");
    for (i = 0; i < n_num; i++) {
        if (getaiteamarray(level.zombie_team).size >= 24) {
            level flag::set(#"hash_29b12646045186fa");
        }
        ai_bat = [[ @bat<scripts\zm\ai\zm_ai_bat.gsc>::function_2e37549f ]](1, a_s_locs[x], 20);
        if (isdefined(ai_bat)) {
            level.var_e12e0420++;
            x++;
            if (b_enemy_markers === 1) {
                ai_bat thread add_new_objective(#"hash_423a75e2700a53ab", "transformation_started");
            }
            ai_bat.no_powerups = 1;
            ai_bat zm_score::function_acaab828();
            ai_bat callback::function_d8abfc3d(#"on_ai_killed", @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_3da8da85);
            if (x == a_s_locs.size) {
                x = 0;
            }
            while (level.var_e12e0420 >= n_current || getaiteamarray(level.zombie_team).size >= 24) {
                waitframe(1);
            }
        }
        level flag::clear(#"hash_29b12646045186fa");
        wait(randomfloatrange(0.2, 0.5));
    }
    level flag::clear(#"hash_29b12646045186fa");
    [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_aa1d0bc6 ]]();
}

wait_transform_add_obj()
{
    level endon("release_objs");
    for (;;) {
        waitresult = level waittill(#"transformation_complete");
        foreach (new_ai in waitresult.new_ai) {
            new_ai thread add_new_objective(#"hash_423a75e2700a53ab");
        }
    }
}

greenhouse_wave_3(b_enemy_markers) {
    level endon(#"hash_b240a9137ecc6f9");
    wait(3.5);
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_enemies = 4;
        var_61584de3 = 2;
        break;
    case 2:
        n_enemies = 7;
        var_61584de3 = 2;
        break;
    case 3:
        n_enemies = 9;
        var_61584de3 = 3;
        break;
    case 4:
        n_enemies = 10;
        var_61584de3 = 4;
        break;
    }
    a_s_greenhouse = struct::get_array("greenhouse_lab_spawns");
    a_s_locs = [];
    foreach (s_greenhouse in a_s_greenhouse) {
        if (s_greenhouse.script_noteworthy === "werewolf_location") {
            a_s_locs[a_s_locs.size] = s_greenhouse;
        }
    }
    level flag::set(#"hash_29b12646045186fa");
    level.var_4b9e58af = 0;
    for (i = 0; i < n_enemies; i++) {
        while (level.var_4b9e58af >= var_61584de3) {
            waitframe(1);
        }
        if (getaiteamarray(level.zombie_team).size >= 20) {
            level flag::set(#"hash_29b12646045186fa");
        }
        s_loc = array::random(a_s_locs);
        ai_werewolf = [[ @zombie_werewolf_util<script_387eab232fe22983.gsc>::function_47a88a0c ]](1, undefined, 1, s_loc, 20);
        if (isalive(ai_werewolf)) {
            IPrintLnBold("Werewolf Valid");
            level.var_4b9e58af++;
            ai_werewolf.no_powerups = 1;
            ai_werewolf zm_score::function_acaab828();
            ai_werewolf.script_noteworthy = "angry_werewolf";
            ai_werewolf.var_126d7bef = 1;
            ai_werewolf.ignore_round_spawn_failsafe = 1;
            ai_werewolf.ignore_enemy_count = 1;
            ai_werewolf.b_ignore_cleanup = 1;
            ai_werewolf callback::function_d8abfc3d(#"on_ai_killed", @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_70e83f44);
            if (level.var_456ece3d !== 1) {
                level.var_456ece3d = 1;
                ai_werewolf thread [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_d89f5961 ]]();
            }
            level flag::clear(#"hash_29b12646045186fa");
        }
        else {
            IPrintLnBold("Werewolf Killed Too Early");
        }
        wait(6 - n_players / 2);
    }
    [[ @namespace_a8113e97<script_9af9e17217da6e6.gsc>::function_acf54a6a ]]();
}

cemetery_lockdown_step_3(skip_step)
{
    level zm_ui_inventory::function_7df6bb60(#"hash_7b00744a8b2143d4", 1);
    level thread cemetery_defend();
    level flag::set(#"stone_visible");
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_6f6fef08 ]]();
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_97ea199a ]]();
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_f3668a9 ]]();
    if (!skip_step) {
        level flag::wait_till(#"cemetery_open");
    }
}

cemetery_defend() {
    level endon(#"cemetery_open");
    level flag::wait_till(#"cemetery_defend");
    b_enemy_markers = level.patch_settings.settings.zm_mansion.lockdowns.enemy_markers === 1;
    if (b_enemy_markers) {
        thread wait_transform_add_obj();
    }
    IPrintLnBold("Lockdown Started");
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
    level thread [[ @mansion_util<scripts\zm\zm_mansion_util.gsc>::function_bb613572 ]]([[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9ca03a70 ]]("spawn_location"), #"cemetery_done");
    level.var_84b2907f = @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_cd4923;
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_cdacc87c ]]();
    level thread cemetery_wave_1(b_enemy_markers);
    level flag::wait_till(#"hash_684b700932f4018f");
    IPrintLnBold("Next Wave");
    level notify("release_objs");
    level thread cemetery_wave_2(b_enemy_markers);
    level flag::wait_till(#"hash_6100d5ec10bed5cc");
    IPrintLnBold("Next Wave");
    level notify("release_objs");
    level thread cemetery_wave_3(b_enemy_markers);
    level flag::wait_till(#"hash_12f4b41ff140e181");
    IPrintLnBold("Next Wave");
    level notify("release_objs");
    level thread cemetery_wave_4(b_enemy_markers);
    level flag::wait_till(#"hash_6a70f9021505a71e");
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_8f5a048e ]]();
}

cemetery_wave_1(b_enemy_markers) {
    switch (getplayers().size) {
    case 1:
        n_num = 10;
        n_current = 8;
        break;
    case 2:
        n_num = 16;
        n_current = 10;
        break;
    case 3:
        n_num = 22;
        n_current = 14;
        break;
    case 4:
        n_num = 28;
        n_current = 16;
        break;
    }
    a_s_locs = [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9ca03a70 ]]();
    level.var_ba177d48 = 0;
    x = 0;
    level flag::set(#"hash_29b12646045186fa");
    for (i = 0; i < n_num; i++) {
        [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9c6147b1 ]]();
        while (level.var_ba177d48 >= n_current) {
            waitframe(1);
        }
        ai_bat = [[ @bat<scripts\zm\ai\zm_ai_bat.gsc>::function_2e37549f ]](1, a_s_locs[x], 20);
        if (isdefined(ai_bat)) {
            level.var_ba177d48++;
            x++;
            if (b_enemy_markers === 1 && !level flag::get(#"hash_684b700932f4018f")) {
                ai_bat thread add_new_objective(#"hash_423a75e2700a53ab", "transformation_started");
            }
            ai_bat.no_powerups = 1;
            ai_bat zm_score::function_acaab828();
            ai_bat callback::function_d8abfc3d(#"on_ai_killed", @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_c9775ddf);
        }
        if (x == a_s_locs.size) {
            x = 0;
        }
        wait(randomfloatrange(0.2, 0.5));
    }
    level flag::clear(#"hash_29b12646045186fa");
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_2bffa0a5 ]]();
}

cemetery_wave_2(b_enemy_markers)
{
    switch (getplayers().size) {
    case 1:
        n_num = 12;
        n_active = 5;
        break;
    case 2:
        n_num = 18;
        n_active = 7;
        break;
    case 3:
        n_num = 25;
        n_active = 10;
        break;
    case 4:
        n_num = 32;
        n_active = 12;
        break;
    }
    a_s_locs = [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9ca03a70 ]]("nosferatu_location");
    level.var_3c6f81fe = 0;
    x = 0;
    var_9f9ebbe8 = 0;
    for (i = 0; i < n_num; i++) {
        while (level.var_3c6f81fe >= n_active) {
            level flag::clear(#"hash_29b12646045186fa");
            waitframe(1);
        }
        level flag::set(#"hash_29b12646045186fa");
        [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9c6147b1 ]]();
        if (randomint(100) > 65 && var_9f9ebbe8 < getplayers().size * 2) {
            b_crimson = 1;
            var_9f9ebbe8++;
        } else {
            b_crimson = 0;
        }
        ai_nos = [[ @zm_ai_nosferatu<scripts\zm\ai\zm_ai_nosferatu.gsc>::function_74f25f8a ]](1, a_s_locs[x], b_crimson);
        if (isdefined(ai_nos)) {
            level.var_3c6f81fe++;
            x++;
            if (b_enemy_markers === 1 && !level flag::get(#"hash_6100d5ec10bed5cc")) {
                ai_nos thread add_new_objective(#"hash_423a75e2700a53ab", "transformation_started");
            }
            ai_nos.no_powerups = 1;
            ai_nos zm_score::function_acaab828();
            ai_nos callback::function_d8abfc3d(#"on_ai_killed", @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_d1027329);
            level flag::clear(#"hash_29b12646045186fa");
            ai_nos waittilltimeout(5 - getplayers().size, #"death");
            level flag::set(#"hash_29b12646045186fa");
        } else {
            i--;
            wait(1);
        }
        if (x == a_s_locs.size) {
            x = 0;
        }
    }
    level flag::clear(#"hash_29b12646045186fa");
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_93b1a1a4 ]]();
}

cemetery_wave_3(b_enemy_markers)
{
    a_s_locs = [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9ca03a70 ]]();
    level.var_50b2aa84 = 0;
    x = 0;
    switch (getplayers().size) {
    case 1:
        n_num = 4;
        break;
    case 2:
        n_num = 6;
        break;
    case 3:
        n_num = 8;
        break;
    case 4:
        n_num = 10;
        break;
    }
    level flag::set(#"hash_29b12646045186fa");
    for (i = 0; i < n_num; i++) {
        [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9c6147b1 ]]();
        ai_bat = [[ @bat<scripts\zm\ai\zm_ai_bat.gsc>::function_2e37549f ]](1, a_s_locs[x], 20);
        if (isdefined(ai_bat)) {
            level.var_50b2aa84++;
            x++;
            if (b_enemy_markers === 1 && !level flag::get(#"hash_12f4b41ff140e181")) {
                ai_bat thread add_new_objective(#"hash_423a75e2700a53ab", "transformation_started");
            }
            ai_bat.no_powerups = 1;
            ai_bat zm_score::function_acaab828();
            ai_bat callback::function_d8abfc3d(#"on_ai_killed", @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_10aefe00);
        }
        if (x == a_s_locs.size) {
            x = 0;
        }
        wait(0.25);
    }
    level flag::clear(#"hash_29b12646045186fa");
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_b77d225a ]]();
}

cemetery_wave_4(b_enemy_markers)
{
    a_s_locs = [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9ca03a70 ]]();
    for (i = 0; i < a_s_locs.size; i++) {
        [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9c6147b1 ]]();
        ai_bat = [[ @bat<scripts\zm\ai\zm_ai_bat.gsc>::function_2e37549f ]](1, a_s_locs[i], 20);
        if (isdefined(ai_bat)) {
            ai_bat.no_powerups = 1;
            ai_bat zm_score::function_acaab828();
        }
        wait(0.25);
    }
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_total = 3;
        n_active = 2;
        break;
    case 2:
        n_total = 5;
        n_active = 2;
        break;
    case 3:
        n_total = 6;
        n_active = 3;
        break;
    case 4:
        n_total = 7;
        n_active = 4;
        break;
    }
    var_4275b4d6 = [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9ca03a70 ]]("werewolf_location");
    var_c3e7058b = [];
    level.var_a908db33 = 0;
    for (i = 0; i < n_total; i++) {
        if (!var_c3e7058b.size) {
            var_c3e7058b = arraycopy(array::randomize(var_4275b4d6));
        }
        s_loc = array::pop(var_c3e7058b, undefined, 0);
        while (level.var_a908db33 >= n_active) {
            level flag::clear(#"hash_29b12646045186fa");
            waitframe(1);
        }
        level flag::set(#"hash_29b12646045186fa");
        [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_9c6147b1 ]]();
        ai_werewolf = [[ @zombie_werewolf_util<script_387eab232fe22983.gsc>::function_47a88a0c ]](1, undefined, 1, s_loc, 20);
        if (isdefined(ai_werewolf)) {
            IPrintLnBold("Werewolf Valid");
            level.var_a908db33++;
            ai_werewolf callback::function_d8abfc3d(#"on_ai_killed", @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_1736030d);
            ai_werewolf.var_126d7bef = 1;
            ai_werewolf.ignore_round_spawn_failsafe = 1;
            ai_werewolf.ignore_enemy_count = 1;
            ai_werewolf.b_ignore_cleanup = 1;
            ai_werewolf.no_powerups = 1;
            ai_werewolf zm_score::function_acaab828();
            level flag::clear(#"hash_29b12646045186fa");
            ai_werewolf waittilltimeout(6 - n_players / 2, #"death");
            level flag::set(#"hash_29b12646045186fa");
            continue;
        }
        else {
            IPrintLnBold("Werewolf Killed Too Early");
        }
        i--;
        wait(1);
    }
    level flag::clear(#"hash_29b12646045186fa");
    level thread [[ @namespace_b6ca3ccc<script_18eb520705898614.gsc>::function_2268f8e8 ]]();
}

forest_lockdown_step_4(skip_step)
{
    level flag::set(#"forest_done");
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::forest_stone ]]();
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_6b0caad3 ]]();
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_52529102 ]]();
    level thread forest_assault();
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_b646e75d ]]();
    if (!isdefined(level.var_fbcb1d5b)) {
        var_e0d9e42f = struct::get("kp1_end");
        level.var_fbcb1d5b = util::spawn_model(#"p8_zm_man_statue_kisa_stone_02", var_e0d9e42f.origin);
        util::wait_network_frame();
        level.var_fbcb1d5b clientfield::set("" + #"wisp_fx", 1);
    }
    if (!isdefined(level.var_abe1b67c)) {
        var_c1395057 = struct::get("kp2_end");
        level.var_abe1b67c = util::spawn_model(#"p8_zm_man_statue_kisa_stone_01", var_c1395057.origin);
        util::wait_network_frame();
        level.var_abe1b67c clientfield::set("" + #"wisp_fx", 1);
    }
    if (!isdefined(level.var_c22f75e6)) {
        var_4c27be7b = struct::get("kp3_end");
        level.var_c22f75e6 = util::spawn_model(#"p8_zm_man_statue_kisa_stone_03", var_4c27be7b.origin);
        util::wait_network_frame();
        level.var_c22f75e6 clientfield::set("" + #"wisp_fx", 1);
    }
    level.var_fbcb1d5b thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_6f244e ]]();
    level.var_abe1b67c thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_6f244e ]]();
    level.var_c22f75e6 thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_6f244e ]]();
    if (!skip_step) {
        level flag::wait_till(#"forest_open");
    }
    level zm_ui_inventory::function_7df6bb60(#"hash_22f192aa6971ec87", 1);
}

forest_assault() {
    level endon(#"hash_106bb5214b1fb1e6");
    level flag::wait_till(#"forest_assault");
    IPrintLnBold("Lockdown Started");
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
    level flag::clear(#"spawn_zombies");
    level flag::clear(#"zombie_drop_powerups");
    level.var_be97413 = 0;
    callback::on_ai_killed(@mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_de68c9b7);
    wait(2);
    level thread function_bb613572([[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_d11cc23b ]](), #"hash_6402d013069eb3a");
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::_angles_cp_medal_no_deaths ]]();
    level flag::wait_till(#"hash_29b12646045186fa");
    IPrintLnBold("Wave Intermission");
    level flag::wait_till_clear(#"hash_29b12646045186fa");
    IPrintLnBold("Next Wave");
    level flag::wait_till("forest_final");
    IPrintLnBold("Next Wave");
    level notify("release_objs");
    function_b5ab717();
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_3d151222 ]](#"forest", #"defend_comp");
    level thread [[ @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_769c307c ]]();
    callback::remove_on_ai_killed(@mansion_triad<scripts\zm\zm_mansion_triad.gsc>::function_de68c9b7);
    level flag::set(#"hash_6402d013069eb3a");
}

function_bb613572(a_s_spawns, a_str_endons, n_spawn_delay = 1, n_round = 20) {
    level flag::clear(#"hash_29b12646045186fa");
    if (isdefined(a_str_endons)) {
        if (!isdefined(a_str_endons)) {
            a_str_endons = [];
        } else if (!isarray(a_str_endons)) {
            a_str_endons = array(a_str_endons);
        }
        foreach (str_endon in a_str_endons) {
            level endon(str_endon);
        }
    }
    level.var_3dd9f9be = 0;
    n_players = getplayers().size;
    if (n_players < 1) {
        n_players = 1;
    }
    n_spawn_delay = n_spawn_delay / n_players;
    var_e8711f44 = 14 + n_players * 2;
    a_sp_zombies = getspawnerarray("spawner_zm_zombie", "targetname");
    var_7c332548 = arraycopy(a_s_spawns);
    b_enemy_markers = level.patch_settings.settings.zm_mansion.lockdowns.enemy_markers === 1;
    if (b_enemy_markers) {
        thread wait_transform_add_obj();
    }
    while (true) {
        while (getaiteamarray(level.zombie_team).size >= var_e8711f44 || level flag::get(#"hash_29b12646045186fa")) {
            wait(0.5);
        }
        s_spawn = array::random(var_7c332548);
        sp_zombie = array::random(a_sp_zombies);
        ai = zombie_utility::spawn_zombie(sp_zombie, undefined, s_spawn, n_round);
        if (isdefined(ai)) {
            level.var_3dd9f9be++;
            if (b_enemy_markers === 1 && !level flag::get("forest_final")) {
                ai thread add_new_objective(#"hash_423a75e2700a53ab");
            }
            ai.var_12745932 = 1;
            arrayremovevalue(var_7c332548, s_spawn, 0);
            if (!var_7c332548.size) {
                var_7c332548 = a_s_spawns;
            }
            wait(n_spawn_delay);
        }
    }
}

function_b5ab717() {
    a_players = getplayers();
    switch (a_players.size) {
    case 1:
        n_num = 3;
        n_active = 2;
        break;
    case 2:
        n_num = 4;
        n_active = 2;
        break;
    case 3:
        n_num = 5;
        n_active = 3;
        break;
    case 4:
        n_num = 6;
        n_active = 4;
        break;
    }
    level thread function_a78b58f6(n_active, n_num, #"hash_6402d013069eb3a");
    while (level.var_b02bf6d2 < n_num) {
        wait(0.5);
    }
}

function_a78b58f6(n_active, var_e05ded9, var_39cddd2a) {
    a_s_center = struct::get_array("forest_center_spawns");
    a_s_north = struct::get_array("forest_n_spawns");
    var_4275b4d6 = [];
    level.var_34ac013b = 0;
    level.var_b02bf6d2 = 0;
    var_70bce1d6 = 0;
    foreach (s_loc in a_s_center) {
        if (s_loc.script_noteworthy === "werewolf_location") {
            var_4275b4d6[var_4275b4d6.size] = s_loc;
        }
    }
    foreach (s_loc in a_s_north) {
        if (s_loc.script_noteworthy === "werewolf_location") {
            var_4275b4d6[var_4275b4d6.size] = s_loc;
        }
    }
    s_loc = array::random(var_4275b4d6);
    while (!level flag::get(var_39cddd2a)) {
        if (isdefined(var_e05ded9) && var_70bce1d6 >= var_e05ded9) {
            return;
        }
        if (level.var_34ac013b < n_active) {
            ai_werewolf = [[ @zombie_werewolf_util<script_387eab232fe22983.gsc>::function_47a88a0c ]](1, undefined, 1, s_loc, 20);
            if (isdefined(ai_werewolf)) {
                IPrintLnBold("Werewolf Valid");
                level.var_34ac013b++;
                var_70bce1d6++;
                ai_werewolf.no_powerups = 1;
                ai_werewolf zm_score::function_acaab828();
                ai_werewolf zm_transform::function_bbaec2fd();
                ai_werewolf forceteleport(s_loc.origin, s_loc.angles);
                ai_werewolf callback::function_d8abfc3d(#"on_ai_killed", @mansion_triad<scripts\zm\zm_mansion_triad.gsc>::teleporter_digger_hacked_before_breached_imp);
            }
            else {
                IPrintLnBold("Werewolf Killed Too Early");
            }
        }
        wait(5);
    }
}