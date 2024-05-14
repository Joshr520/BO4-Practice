monitor_menu_responses()
{
    for (;;) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        intpayload = waitresult.intpayload;
        ShieldLog("Menu Response: " + menu + ", " + response + ", " + intpayload);
        if (menu != #"ClientToServer") {
            continue;
        }
        switch (response) {
            case #"points": {
                self.score = intpayload;
                break;
            }
            case #"specialist_level": {
                self zm_hero_weapon::function_45b7d6c1(intpayload - 1);
                self zm_hero_weapon::hero_give_weapon(level.hero_weapon[self.var_b708af7b][intpayload - 1], 0, 1);
                self.var_da2f5f0b = 0;
                break;
            }
            case #"start_settings": {
                if (intpayload & (1 << 0)) {
                    self thread godmode();
                }
                if (intpayload & (1 << 1)) {
                    self thread infinite_ammo();
                }
                if (intpayload & (1 << 2)) {
                    self thread perkaholic();
                }
                else {
                    if (intpayload & (1 << 3)) {
                        self thread activate_perk_slot(0);
                    }
                    if (intpayload & (1 << 4)) {
                        self thread activate_perk_slot(1);
                    }
                    if (intpayload & (1 << 5)) {
                        self thread activate_perk_slot(2);
                    }
                    if (intpayload & (1 << 6)) {
                        self thread activate_perk_slot(3);
                    }
                }
                break;
            }
            case #"fast_restart": {
                if (self IsHost()) {
                    Map_Restart(0);
                }
                break;
            }
            case #"noclip_toggle": {
                self notify("noclip_toggle");
                break;
            }
            case #"camera_set_position": {
                self notify("camera_set_position");
                break;
            }
            case #"camera_toggle": {
                self notify("camera_toggle");
                break;
            }
            case #"godmode": {
                self thread godmode();
                break;
            }
            case #"infinite_ammo": {
                self thread infinite_ammo();
                break;
            }
            default: {
                break;
            }
        }
    }
}