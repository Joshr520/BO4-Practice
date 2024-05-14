detour mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_738f7574(n_stage)
{
    if (IsDefined(level.patch_settings) && level.patch_settings.enabled) {
        switch (n_stage) {
            case 1: {
                LUINotifyEvent(#"boss_health_toggle", 1, 1);
                LUINotifyEvent(#"boss_health_update", 2, Int(level.s_boss.var_c962047c), Int(level.s_boss.var_c962047c));
                break;
            }
            case 2: {
                LUINotifyEvent(#"boss_health_toggle", 1, 0);
                break;
            }
            case 3: {
                LUINotifyEvent(#"boss_health_toggle", 1, 1);
                LUINotifyEvent(#"boss_health_update", 2, Int(level.s_boss.var_c962047c), Int(level.s_boss.var_c962047c));
                break;
            }
            default: {
                break;
            }
        }
    }
    return [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_738f7574 ]](n_stage);
}

detour mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_bb612e31(n_stage, var_c962047c) {
    if (!IsDefined(level.patch_settings) || !level.patch_settings.enabled || !level.patch_settings.settings.zm_mansion.boss_health_scaling || level.patch_settings.settings.zm_mansion.boss_health_scaling == util::get_active_players().size) {
        return [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_bb612e31 ]](n_stage, var_c962047c);
    }
    level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_2b6b4a44 ]]();
    if (n_stage == 2) {
        var_82b2ec02 = 1;
    } else {
        var_82b2ec02 = 0;
    }
    level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_e0b1cf29 ]](var_82b2ec02);
    var_2aaf6cdb = 0.5;
    a_players = util::get_active_players();
    foreach (player in a_players) {
        var_2aaf6cdb = var_2aaf6cdb + 0.52;
    }
    if (isdefined(var_c962047c)) {
        var_2aaf6cdb = 0.5 + (0.52 * Min(level.patch_settings.settings.zm_mansion.boss_health_scaling, 4));
        if (var_c962047c > 0) {
            level.s_boss.var_c962047c = var_2aaf6cdb * var_c962047c;
        } else {
            level.s_boss.var_c962047c = -1;
        }
    }
    level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_542eeaa7 ]](n_stage);
    level waittill(#"hash_38f29f9cb03586ea");
}

detour mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_e9cc6379(var_4642da4d, var_732926d1 = 0) {
    if (!IsDefined(level.patch_settings) || !level.patch_settings.enabled) {
        return [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_e9cc6379 ]](var_4642da4d, var_732926d1);
    }
    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"end_game", #"intermission");
    n_round = level.var_d6f059f7;
    var_574e94ee = struct::get_array(#"hash_49002dbb418e71a1");
    n_max_active_ai = 16 + level.var_f3c4bd00;
    switch (level.var_f3c4bd00) {
    case 1:
        var_91a2fd38 = 1;
        break;
    case 2:
        var_91a2fd38 = 2;
        break;
    case 3:
        var_91a2fd38 = 3;
        break;
    case 4:
        var_91a2fd38 = 4;
        break;
    }
    var_c441a64d = undefined;
    var_d9ca600e = 0;
    while (true) {
        wait(randomfloatrange(20, 25));
        var_50e016a7 = level.var_83c0592c + var_4642da4d;
        var_f67b2fc0 = 0;
        while (var_f67b2fc0 < var_91a2fd38) {
            while (getaiteamarray(level.zombie_team).size >= n_max_active_ai) {
                util::wait_network_frame();
                level [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::boss_cleanup_zombie ]]();
            }
            level waittill(#"hash_71dbe2201553374b");
            ai_nosferatu = [[ @zm_ai_nosferatu<scripts\zm\ai\zm_ai_nosferatu.gsc>::function_74f25f8a ]](1, undefined, 1, n_round);
            if (isalive(ai_nosferatu)) {
                if (var_732926d1 == 1 && level.patch_settings.settings.zm_mansion.enemy_markers === 1) {
                    ai_nosferatu thread add_new_objective(#"hash_423a75e2700a53ab");
                }
                ai_nosferatu.var_85480576 = 1;
                var_f67b2fc0++;
                wait(randomfloatrange(3, 6));
            }
        }
        var_66677bf4 = getaiarchetypearray(#"nosferatu");
        var_59bff05d = var_66677bf4.size;
        while (var_59bff05d > 0) {
            foreach (var_c441a64d in var_66677bf4) {
                if (!isalive(var_c441a64d)) {
                    var_59bff05d--;
                }
            }
            util::wait_network_frame(2);
        }
        var_d9ca600e++;
        if (var_732926d1 > 0) {
            if (!level flag::get(#"hash_f4dfa99c5e22bc6") && var_d9ca600e >= var_732926d1) {
                level flag::set(#"hash_f4dfa99c5e22bc6");
            }
            var_d9ca600e = 0;
        }
        util::wait_network_frame();
    }
}