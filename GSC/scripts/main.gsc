init()
{
    level endon("shield_practice_kill");
    
    level flag::wait_till("practice_enabled");
    thread init_box_patch();

    SetDvar("sv_cheats", 1);
    SetGameTypeSetting("zmshowtimer", level.patch_settings.timer === 1);

    switch (level.patch_settings.map) {
        case "zm_escape": {
            zm_escape_quest_init();
            break;
        }
        case "zm_mansion": {
            zm_mansion_quest_init();
            break;
        }
        default: {
            break;
        }
    }

    if (level.patch_settings.zombie_counter === 1) {
        thread zombie_counter_run();
    }
}

on_connect()
{
    level endon("shield_practice_kill");
    
    if (self IsTestClient()) {
        return;
    }

    self thread monitor_menu_responses();

    level flag::wait_till("practice_enabled");
    
    switch (level.patch_settings.map) {
        case "zm_escape": {
            switch (level.patch_settings.patch) {
                case "boss":
                case "chals": {
                    self.talisman_special_startlv2 = 1;
                    break;
                }
                default: {
                    return;
                }
            }
            break;
        }
        case "zm_mansion": {
            switch (level.patch_settings.patch) {
                case "boss":
                case "lockdown_2":
                case "lockdown_3":
                case "lamps": {
                    self.talisman_special_startlv2 = 1;
                    break;
                }
                default: {
                    return;
                }
            }
            break;
        }
        default: {
            break;
        }
    }
}

on_spawned()
{
    level endon("shield_practice_kill");
    
    if (self IsTestClient()) {
        return;
    }

    level flag::wait_till("practice_enabled");
    level flag::wait_till("gameplay_started");

    switch (level.patch_settings.map) {
        case "all": {
            break;
        }
        case "zm_zodt8": {
            self thread zm_zodt8_practice();
            break;
        }
        case "zm_escape": {
            self thread zm_escape_practice();
            break;
        }
        case "zm_mansion": {
            self thread zm_mansion_practice();
            break;
        }
    }

    if (level.patch_settings.timer) {
        level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
    }

    self thread noclip_bind();
    self thread camera_set_position();
    self thread camera_toggle();
}

empty_func(arg1, arg2)
{

}