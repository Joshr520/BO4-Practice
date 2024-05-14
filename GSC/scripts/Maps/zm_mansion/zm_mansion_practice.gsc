zm_mansion_quest_init()
{
    switch (level.patch_settings.patch) {
        case "lockdown_1": {
            thread override_quest(#"hash_559b7237b8acece2", "step_1", &empty_func, &empty_func);
            thread override_quest(#"hash_559b7237b8acece2", "step_2", &empty_func, &empty_func);
            thread override_quest(#"hash_559b7237b8acece2", "step_3", &empty_func, &empty_func);
            thread override_quest(#"hash_559b7237b8acece2", "step_4", &greenhouse_lockdown_step_4);
            break;
        }
        case "lockdown_2": {
            thread override_quest(#"hash_578d0d7709a00e6e", "step_1", &empty_func, &empty_func);
            thread override_quest(#"hash_578d0d7709a00e6e", "step_2", &empty_func, &empty_func);
            thread override_quest(#"hash_578d0d7709a00e6e", "step_3", &cemetery_lockdown_step_3);
            break;
        }
        case "lockdown_3": {
            thread override_quest(#"zm_mansion_triad", "step_1", &empty_func, &empty_func);
            thread override_quest(#"zm_mansion_triad", "step_2", &empty_func, &empty_func);
            thread override_quest(#"zm_mansion_triad", "step_3", &empty_func, &empty_func);
            thread override_quest(#"zm_mansion_triad", "step_4", &forest_lockdown_step_4);
            break;
        }
        case "lamps": {
            thread override_quest(#"hash_559b7237b8acece2", "step_1", &empty_func, &empty_func);
            thread override_quest(#"hash_559b7237b8acece2", "step_2", &empty_func, &empty_func);
            thread override_quest(#"hash_559b7237b8acece2", "step_3", &empty_func, &empty_func);
            thread override_quest(#"hash_559b7237b8acece2", "step_4", &greenhouse_lockdown_step_4_lamps);
        }
        default: {
            break;
        }
    }
}

zm_mansion_practice()
{
    switch (level.patch_settings.patch) {
        case "boss": {
            thread zm_mansion_boss_setup();
            break;
        }
        case "lockdown_1": {
            thread zm_mansion_lockdown_setup(1);
            break;
        }
        case "lockdown_2": {
            thread zm_mansion_lockdown_setup(2);
            break;
        }
        case "lockdown_3": {
            thread zm_mansion_lockdown_setup(3);
            break;
        }
        case "lamps": {
            thread zm_mansion_lamps_setup();
            break;
        }
        default: {
            break;
        }
    }
    thread zm_mansion_ww_lvl3_quest_init();
    thread zm_mansion_scratches_init();
    thread zm_mansion_wicker_ghost_init();
}