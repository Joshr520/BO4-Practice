// 1 - essex, 2 - shield, 3 - strife, 4 - scratches, dl_loc - doll, bull_loc - noose, monkey_loc - will
zm_mansion_get_pap_ghost(n_crystal)
{
    settings = level.patch_settings.settings.zm_mansion.pap.ghosts;
    a_painting_ghosts = [];
    a_trophy_ghosts = [];
    if (settings.essex) {
        a_painting_ghosts[a_painting_ghosts.size] = "painting_1";
    }
    if (settings.shield) {
        a_painting_ghosts[a_painting_ghosts.size] = "painting_2";
    }
    if (settings.strife) {
        a_painting_ghosts[a_painting_ghosts.size] = "painting_3";
    }
    if (settings.scratches) {
        a_painting_ghosts[a_painting_ghosts.size] = "painting_4";
    }
    if (settings.doll) {
        a_trophy_ghosts[a_trophy_ghosts.size] = "dl_loc";
    }
    if (settings.noose && n_crystal != 2) {
        a_trophy_ghosts[a_trophy_ghosts.size] = "bull_loc";
    }
    if (settings.will && n_crystal != 3) {
        a_trophy_ghosts[a_trophy_ghosts.size] = "monkey_loc";
    }
    self.var_1ed09409 = [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_4e8b75e0 ]]();
    if (!a_painting_ghosts.size && !a_trophy_ghosts.size) {
        switch (n_crystal) {
            case 1: {
                self.str_hint = [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_639c87e1 ]](self.var_1ed09409);
                break;
            }
            case 2: {
                if (self.var_1ed09409 === "trophy") {
                    self.str_hint = array::random(array("monkey_loc", "dl_loc"));
                }
                else {
                    self.str_hint = [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_639c87e1 ]](self.var_1ed09409);
                }
                break;
            }
            case 3: {
                if (self.var_1ed09409 === "trophy") {
                    self.str_hint = array::random(array("bull_loc", "dl_loc"));
                }
                else {
                    self.str_hint = [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_639c87e1 ]](self.var_1ed09409);
                }
                break;
            }
            default: {
                break;
            }
        }
    }
    else if (!a_painting_ghosts.size) {
        self.var_1ed09409 = "trophy";
        self.str_hint = array::random(a_trophy_ghosts);
    }
    else if (!a_trophy_ghosts.size) {
        self.var_1ed09409 = "painting";
        self.str_hint = array::random(a_painting_ghosts);
    }
    else {
        if (self.var_1ed09409 == "painting") {
            self.str_hint = array::random(a_painting_ghosts);
        }
        else {
            self.str_hint = array::random(a_trophy_ghosts);
        }
    }
}

// clock_star - billiards, clock_horseshoe - dining, clock_hook - main
zm_mansion_get_pap_clock()
{
    settings = level.patch_settings.settings.zm_mansion.pap.clocks;
    a_clocks = [];
    if (settings.billiards) {
        a_clocks[a_clocks.size] = "clock_star";
    }
    if (settings.dining) {
        a_clocks[a_clocks.size] = "clock_horseshoe";
    }
    if (settings.main) {
        a_clocks[a_clocks.size] = "clock_hook";
    }
    if (!a_clocks.size) {
        a_clocks = array("clock_star", "clock_horseshoe", "clock_hook");
    }
    self.str_hint = array::random(a_clocks);
}

zm_mansion_get_pap_vamps()
{
    settings = level.patch_settings.settings.zm_mansion.pap.vamp_lockdown;
    a_vamps = [];
    if (settings.cemetery) {
        a_vamps[a_vamps.size] = "cemetery";
    }
    if (settings.greenhouse) {
        a_vamps[a_vamps.size] = "garden";
    }
    if (!a_vamps.size) {
        a_vamps = array("cemetery", "garden");
    }
    self.str_hint = array::random(a_vamps);
}

detour mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_9ce2b677(var_f0e6c7a2, ent) {
    if (!IsDefined(level.patch_settings) || !level.patch_settings.enabled) {
        return self [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_9ce2b677 ]](var_f0e6c7a2, ent);
    }
    
    if (GetPlayers().size > 2) {
        n_souls_required = level.var_71561996;
    }
    else if (GetPlayers().size > 1) {
        n_souls_required = level.var_d4fada4a;
    }
    else {
        n_souls_required = level.var_bc07224f;
    }
    level.var_239e2979++;
    if (level.var_239e2979 >= n_souls_required) {
        level flag::set("bedroom_charged");
        [[ @namespace_617a54f4<script_3e5ec44cfab7a201.gsc>::function_2a94055d ]](var_f0e6c7a2.script_string);
        var_99a245 = GetEnt("gazing_stone_main_hall", "targetname");
        var_99a245 clientfield::set("" + #"hash_6babc320ed9a08f1", 1);
        if (!var_f0e6c7a2 flag::exists("flag_gazing_stone_in_use")) {
            var_f0e6c7a2 flag::init("flag_gazing_stone_in_use");
        }
        var_47323b73 = var_f0e6c7a2 zm_unitrigger::create(@mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_5815f500, 64, @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_5713470b);
        var_47323b73.var_f0e6c7a2 = var_f0e6c7a2;
        if (level.a_str_zones[0] == "main_hall") {
            var_47323b73.var_1ed09409 = "nos";
            var_47323b73 zm_mansion_get_pap_vamps();
        }
        else if (level.a_str_zones[1] == "main_hall") {
            var_47323b73.var_1ed09409 = "clock";
            var_47323b73 zm_mansion_get_pap_clock();
        }
        else {
            var_47323b73 zm_mansion_get_pap_ghost(1);
        }
        var_47323b73.mdl_key = level.var_eab529d7;
        var_47323b73.s_loc = struct::get("key_main_hall_loc");
        var_47323b73.var_e62bb9d2 = GetEnt("gazing_stone_main_hall", "targetname");
        var_99a245 thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_8b6c61d3 ]](level.var_eab529d7);
        var_f0e6c7a2 thread [[ @zm_mansion_sound<scripts\zm\zm_mansion_sound.gsc>::function_70c90053 ]]();
    }
}

detour mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_da937c94(var_f0e6c7a2, ent) {
    if (!IsDefined(level.patch_settings) || !level.patch_settings.enabled) {
        return self [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_da937c94 ]](var_f0e6c7a2, ent);
    }
    
    if (GetPlayers().size > 2) {
        n_souls_required = level.var_71561996;
    }
    else if (GetPlayers().size > 1) {
        n_souls_required = level.var_d4fada4a;
    }
    else {
        n_souls_required = level.var_bc07224f;
    }
    level.var_a5be39a5++;
    if (level.var_a5be39a5 >= n_souls_required) {
        level flag::set("cellar_charged");
        [[ @namespace_617a54f4<script_3e5ec44cfab7a201.gsc>::function_2a94055d ]](var_f0e6c7a2.script_string);
        var_d8f56b29 = GetEnt("gazing_stone_cellar", "targetname");
        var_d8f56b29 clientfield::set("" + #"hash_6babc320ed9a08f1", 1);
        if (!var_f0e6c7a2 flag::exists("flag_gazing_stone_in_use")) {
            var_f0e6c7a2 flag::init("flag_gazing_stone_in_use");
        }
        var_47323b73 = var_f0e6c7a2 zm_unitrigger::create(@mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_5815f500, 64, @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_5713470b);
        var_47323b73.var_f0e6c7a2 = var_f0e6c7a2;
        if (level.a_str_zones[0] == "greenhouse") {
            var_47323b73.var_1ed09409 = "nos";
            var_47323b73 zm_mansion_get_pap_vamps();
        }
        else if (level.a_str_zones[1] == "greenhouse") {
            var_47323b73.var_1ed09409 = "clock";
            var_47323b73 zm_mansion_get_pap_clock();
        }
        else {
            var_47323b73 zm_mansion_get_pap_ghost(2);
        }
        var_47323b73.mdl_key = level.var_a46e88e5;
        var_47323b73.s_loc = struct::get("key_greenhouse_loc");
        var_47323b73.vol_transform = GetEnt("vol_transform_greenhouse", "targetname");
        var_47323b73.var_e62bb9d2 = GetEnt("gazing_stone_cellar", "targetname");
        var_d8f56b29 thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_8b6c61d3 ]](level.var_a46e88e5);
        var_f0e6c7a2 thread [[ @zm_mansion_sound<scripts\zm\zm_mansion_sound.gsc>::function_70c90053 ]]();
    }
}

detour mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_2c902b77(var_f0e6c7a2, ent) {
    if (!IsDefined(level.patch_settings) || !level.patch_settings.enabled) {
        return self [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_9ce2b677 ]](var_f0e6c7a2, ent);
    }
    
    if (GetPlayers().size > 2) {
        n_souls_required = level.var_71561996;
    }
    else if (GetPlayers().size > 1) {
        n_souls_required = level.var_d4fada4a;
    }
    else {
        n_souls_required = level.var_bc07224f;
    }
    level.var_be779a9e++;
    if (level.var_be779a9e >= n_souls_required) {
        level flag::set("library_charged");
        [[ @namespace_617a54f4<script_3e5ec44cfab7a201.gsc>::function_2a94055d ]](var_f0e6c7a2.script_string);
        var_aa527474 = GetEnt("gazing_stone_library", "targetname");
        var_aa527474 clientfield::set("" + #"hash_6babc320ed9a08f1", 1);
        if (!var_f0e6c7a2 flag::exists("flag_gazing_stone_in_use")) {
            var_f0e6c7a2 flag::init("flag_gazing_stone_in_use");
        }
        var_47323b73 = var_f0e6c7a2 zm_unitrigger::create(@mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_5815f500, 64, @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_5713470b);
        var_47323b73.var_f0e6c7a2 = var_f0e6c7a2;
        if (level.a_str_zones[0] == "library") {
            var_47323b73.var_1ed09409 = "nos";
            var_47323b73 zm_mansion_get_pap_vamps();
        }
        else if (level.a_str_zones[1] == "library") {
            var_47323b73.var_1ed09409 = "clock";
            var_47323b73 zm_mansion_get_pap_clock();
        }
        else {
            var_47323b73 zm_mansion_get_pap_ghost(3);
        }
        var_47323b73.mdl_key = level.var_192555d1;
        var_47323b73.s_loc = struct::get("key_library_loc");
        var_47323b73.vol_transform = GetEnt("vol_transform_library", "targetname");
        var_47323b73.var_e62bb9d2 = GetEnt("gazing_stone_library", "targetname");
        var_aa527474 thread [[ @mansion_pap<scripts\zm\zm_mansion_pap_quest.gsc>::function_8b6c61d3 ]](level.var_192555d1);
        var_f0e6c7a2 thread [[ @zm_mansion_sound<scripts\zm\zm_mansion_sound.gsc>::function_70c90053 ]]();
    }
}