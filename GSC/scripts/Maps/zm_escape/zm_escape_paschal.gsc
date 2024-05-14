zm_escape_challenge_setup()
{
    self.score = 7500;
    self thread zm_perks::function_cc24f525();

    foreach (weapon in self GetWeaponsListPrimaries()) {
        self TakeWeapon(weapon);
    }
    if (level.patch_settings.patch == "boss") {
        self zm_weapons::weapon_give(GetWeapon("smg_fastfire_t8_upgraded"), 0, 1, 334);
        self zm_weapons::weapon_give(GetWeapon("ww_blundergat_t8_upgraded"));
        self GadgetPowerSet(level.var_a53a05b5, 15);
    }
    else {
        self zm_weapons::weapon_give(GetWeapon("smg_fastfire_t8"), 0, 1, 334);
        self zm_weapons::weapon_give(GetWeapon("ww_blundergat_t8"));
    }

    self zm_weapons::weapon_give(GetWeapon("tomahawk_t8"));
    self GiveWeapon(level.var_d7e67022);
    self GiveWeapon(GetWeapon("spoon_alcatraz"));
    wait 0.1;
    self.var_9fd623ed = 6;
    self.var_9fd623ed = self.var_9fd623ed + 12;
    self.var_9fd623ed = math::clamp(self.var_9fd623ed, 0, self.var_f7c822b5 * 3);
    self thread [[ @zm_weap_spectral_shield<scripts\zm\weapons\zm_weap_spectral_shield.gsc>::function_804309c ]]();
    self notify(#"hash_22a49f7903e394a5");
    self playsound(#"hash_19d5ba8ff22edcce");
    self.var_184a3854 = 2750;
    self.var_184a3854 = 3050;
    self SetEverHadWeaponAll(1);

    if (level.patch_settings.patch != "boss") {
        self SetOrigin((-1850, 7880, 1430));
        self SetPlayerAngles((0, 90, 0));
        self FreezeControls(1);
        self val::set(#"hash_69d303dd5e34b7b7", "ignoreme");
    }

    if (!self IsHost()) {
        return;
    }

    self craft_parts();

    if (level.patch_settings.patch == "boss") {
        getent("jar_1", "targetname").s_interact notify("trigger_activated", {#e_who:self});
        level flag::wait_till(#"hash_4fac802bd5dcebf4");
        level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
        return;
    }

    SetSlowMotion(1, 10, 0.05);
    thread zombie_open_sesame();

    level flag::wait_till_any(array("power_on2", "power_on"));
    wait 0.1;
    getent("t_catwalk_door_open", "targetname") notify("trigger", {#activator:self});
    wait 0.1;
    trigger::use("t_catwalk_event_00", "targetname", self);
    level flag::wait_till(#"hash_6019aeb57ae7e6b5");
    wait 0.5;
    getent("t_catwalk_event_10", "targetname") notify("enemies_spawned");
    level.var_20cff6f0 = 0;
    foreach (ai_zombie in GetEntArray("catwalk_event_zombie", "script_noteworthy")) {
        ai_zombie Kill();
    }
    wait 0.1;
    level.var_e120ae98 = undefined;
    level flag::set("catwalk_event_completed");
    level notify("7208d0e939378c16");
    level notify("trig_catwalk_event_completed");
    foreach (t_catwalk_event in GetEntArray("catwalk_event_triggers", "script_noteworthy")) {
        t_catwalk_event Delete();
    }

    round = 1;
    while (level.var_33be9958 <= 12) {
        level.var_33be9958 = round + RandomIntRange(level.var_deee7afe, level.var_66ff42da);
        round = level.var_33be9958;
    }

    level flag::clear("zombie_drop_powerups");
    while (level.n_total_kills < 200) {
        n_kills_needed = zm_powerups::function_2ff352cc();
        level.n_total_kills = level.n_total_kills + n_kills_needed;
        level [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_a7a5570e ]]();
    }
    level.var_1dce56cc = level.n_total_kills + zm_powerups::function_2ff352cc();
    level flag::set("zombie_drop_powerups");

    thread activate_and_move_pap();

    foreach (dog in level.var_4952e1) {
        dog notify(#"hash_13c5316203561c4f");
        level.n_soul_catchers_charged++;
        dog.is_charged = 1;
        dog notify("fully_charged");
        level thread [[ @zm_escape_weap_quest<scripts\zm\zm_escape_weap_quest.gsc>::function_5fd2c72e ]]();
        dog.var_740e1e0e clientfield::set("" + #"hash_5ecbfb9042fc7f38", 0);
        dog.var_740e1e0e SetModel("p8_zm_esc_dream_catcher");
    }
    level flag::set("soul_catchers_charged");

    level flag::wait_till(#"hash_7039457b1cc827de");
    wait 0.1;
    getent("nixie_door_trigger", "targetname") notify("trigger");

    wait 5;
    goto_round(12);

    wait 40;

    old_bgb_func = level.bgb["zm_bgb_anywhere_but_here"].activation_func;
    level.bgb["zm_bgb_anywhere_but_here"].activation_func = &empty_func;
    level.bgb["zm_bgb_anywhere_but_here"].var_81f8ab0f = 240;

    SetSlowMotion(10, 1, 0.05);
    zm_vo::function_3c173d37(self.origin, 10000);
    foreach (player in level.activeplayers) {
        player util::delay(5, undefined, &val::reset, #"hash_69d303dd5e34b7b7", "ignoreme");
        player FreezeControls(0);
        foreach (n_index, bgb in player.bgb_pack) {
            if (bgb == #"zm_bgb_anywhere_but_here") {
                player bgb_pack::activate_elixir(n_index);
                break;
            }
        }
    }

    level.var_973488a5 = 11 + RandomIntRangeInclusive(6, 8);
    level thread zombie_dog_util::dog_enable_rounds(1);
    level.dog_round_count = 3;
    zombie_utility::set_zombie_var("zombie_drop_item", 0);

    self waittill("end_slot_cooldown" + n_index);
    foreach (player in GetPlayers()) {
        player [[ @bgb_pack<scripts\zm_common\zm_bgb_pack.gsc>::function_f2173c97 ]](0);
    }
    level.bgb["zm_bgb_anywhere_but_here"].activation_func = old_bgb_func;
    level.bgb["zm_bgb_anywhere_but_here"].var_81f8ab0f = undefined;
}

paschal_step_1(skip_step)
{
    level flag::wait_till("all_players_spawned");
    var_96e39e55 = getent("w_h_h_d_clip_m", "targetname");
    var_ebdd41e3 = struct::get("s_p_s1_w_b");
    var_9a23b2c6 = var_ebdd41e3.scene_ents[#"door"];
    var_9a23b2c6 hidepart("tag_wall_damaged");
    var_9a23b2c6 hidepart("tag_wall_destroyed");
    var_ebdd41e3 scene::play("damaged");
    var_d388f9de = struct::get(#"hash_1fb558842bdc2690");
    var_db15362c = var_d388f9de.scene_ents[#"prop 1"];
    var_db15362c clientfield::set("" + #"hash_376c030aee1d6ccb", 1);
    var_38e9df50 = struct::get(#"s_r_w_a_r");
    var_38e9df50 scene::init();
    level clientfield::set("" + #"attic_room", 1);
    if (!IsDefined(level.var_dcdad7b1)) {
        level.var_dcdad7b1 = util::spawn_model("tag_origin", var_96e39e55.origin);
    }
    level.var_dcdad7b1 thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_bb44b334 ]]();
    level.var_dcdad7b1 playsound(#"hash_25a9868631824fea");
    var_9a23b2c6 stoploopsound();
    music::setmusicstate("escape_attic");
    var_ebdd41e3 thread scene::play("destroyed");
    var_15d876af = getent("w_h_h_d_clip", "targetname");
    var_15d876af connectpaths();
    var_15d876af notsolid();
    var_96e39e55 connectpaths();
    var_96e39e55 notsolid();
    zm_zonemgr::enable_zone("zone_warden_home");
    level flag::set("activate_warden_house_2_attic");
    level thread scene::init("s_r_w_a_r");
    level thread scene::init_streamer(#"p8_fxanim_zm_esc_wardensattic_reveal_bundle", #"allies", 0, 0);
    s_orb = struct::get("s_house_orb");
    level.var_659daf1d = array("tag_socket_f");
    level flag::set(#"hash_61bba9aa86f61865");
    level thread function_cf51e21a();
    level flag::wait_till_all(array(#"hash_61bba9aa86f61865", #"hash_379fc22ed85f0dbc"));
    level.var_dcdad7b1 delete();
}

paschal_step_2(skip_step)
{
    level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 2);
    if (skip_step) {
        return;
    }
    var_de399497 = struct::get("k_fx_pos");
    e_activator = var_de399497 zm_unitrigger::function_fac87205("", 64);
    level.var_bbc27d0e = util::spawn_model(#"hash_4c06bc763e373f0f", var_de399497.origin, var_de399497.angles);
    level.var_bbc27d0e playsound(#"hash_5109ee79a5d045f0");
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::pause_zombies ]](1);
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", GetTime());
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_9465204c ]](level.players[0]);
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::pause_zombies ]](0);
}

paschal_step_4(skip_step) {
    level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 4);
    level flag::init(#"hash_67f8280f4ac19125");
    level flag::init(#"hash_2ae01ca8561c1819");
    level flag::init(#"hash_66efd29e4fb12cb5");
    level flag::init(#"hash_46e13471f21f98d0");
    level flag::init(#"hash_6bacf600a3126b18");
    level.var_d668eae7[0] spawner::add_spawn_function(@paschal<scripts\zm\zm_escape_paschal.gsc>::function_90ce7724);
    if (skip_step) {
        level.lighting_state = 2;
        self util::set_lighting_state(level.lighting_state);
        level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_f52bbbb5 ]]();
        return;
    }
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_2aee0563 ]]();
    SetSlowMotion(1, 10, 0.05);
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_adb645f2 ]]();
    level.var_f88b13d6 = level.brutus_max_count;
    level.brutus_max_count = 4;
    level.check_for_valid_spawn_near_team_callback = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_5bcc5537;
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_9e1e3766 ]]();
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_6bf2e4d ]]();
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_27097e44 ]]();
    level.lighting_state = 2;
    self util::set_lighting_state(level.lighting_state);
    wait(29);
    level.var_d804e8a9 = undefined;
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_ddc5b4e9 ]]();
    SetSlowMotion(10, 1, 0.05);
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_1c978623 ]]();
    level flag::set(#"hash_2ae01ca8561c1819");
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_474ba3b0 ]]();
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_2e3734e2 ]]();
    level waittill(#"hash_66efd29e4fb12cb5");
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_ddf8f11 ]]();
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_8e52cae7 ]]();
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_8562a40f ]]();
}

function_cf51e21a()
{
    var_d388f9de = struct::get(#"hash_1fb558842bdc2690");
    var_d388f9de thread scene::play();
    playsoundatposition(#"hash_4731813c2e1aa578", var_d388f9de.origin);
    wait(0.5);
    var_db15362c = var_d388f9de.scene_ents[#"prop 1"];
    var_db15362c clientfield::set("" + #"hash_376c030aee1d6ccb", 2);
    var_d7cbafba = struct::get(#"hash_32ae80e5cfea37c3");
    var_d7cbafba.mdl_fx = util::spawn_model(#"tag_origin", var_d7cbafba.origin, var_d7cbafba.angles);
    var_d7cbafba.mdl_fx clientfield::set("" + #"hash_201ef69f0a0a5dce", 1);
    var_f7afe1a0 = getent("w_h_f_d", "targetname");
    var_f7afe1a0 show();
    exploder::kill_exploder("fxexp_lighthouse_light");
    var_de399497 = struct::get("k_fx_pos");
    var_de399497 thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_9e723e9 ]]();
    level thread scene::play("s_r_w_a_r", "Main & Idle Loop Out");
    var_7034e8dd = getent("w_h_f", "targetname");
    var_7034e8dd hide();
    level flag::set(#"hash_379fc22ed85f0dbc");
}

activate_and_move_pap()
{
    GetEnt("pap_shock_box", "script_string") notify(#"hash_7e1d78666f0be68b");
    level flag::wait_till("pap_quest_completed");
    pap = GetEntArray("zm_pack_a_punch", "targetname")[0];
    level.var_2ba5b206 = 9 + RandomIntRangeInclusive(2, 4);
    if (level.var_2ba5b206 <= 12) {
        level.var_2ba5b206 = level.var_2ba5b206 + RandomIntRangeInclusive(2, 4);
        switch (pap.script_string) {
        case "roof":
            fx = "lgtexp_pap_rooftops_on";
            scene_depart = #"hash_41fada5e44b023a9";
            scene_arrive = "aib_vign_zm_mob_pap_ghosts";
            break;
        case "building_64":
            fx = "lgtexp_pap_b64_on";
            scene_depart = "aib_vign_zm_mob_pap_ghosts_remove_b64";
            scene_arrive = "aib_vign_zm_mob_pap_ghosts_b64";
            break;
        case "power_house":
            fx = "lgtexp_pap_powerhouse_on";
            scene_depart = #"hash_7cc7d9f749a02418";
            scene_arrive = "aib_vign_zm_mob_pap_ghosts_power_house";
            break;
        }
        exploder::stop_exploder(fx);
        pap zm_pack_a_punch::function_bb629351(0);
        level thread scene::play(scene_depart);
        pap zm_pack_a_punch::function_bb629351(0, "hidden");
        pap zm_pack_a_punch::set_state_hidden();
        a_e_pack = GetEntArray("zm_pack_a_punch", "targetname");
        e_pack = pap;
        while (e_pack == pap) {
            e_pack = array::random(a_e_pack);
        }
        level thread scene::play(scene_arrive);
        e_pack zm_pack_a_punch::function_bb629351(1);
        [[ @pap_quest<scripts\zm\zm_escape_pap_quest.gsc>::pap_debris ]](0, e_pack.script_string);
        e_pack thread [[ @pap_quest<scripts\zm\zm_escape_pap_quest.gsc>::function_c0bc0375 ]]();
        pap notify(#"hash_168e8f0e18a79cf8");
    }
}