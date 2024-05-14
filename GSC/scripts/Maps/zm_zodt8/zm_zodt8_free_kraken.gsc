zm_zodt8_free_kraken_helper()
{
    level flag::set(#"hash_2d1cd18f39ac5fa7");
    
    e_path = getent("berths_walk", "targetname");
    foreach (e_player in GetPlayers()) {
        e_player thread berths_walk_monitor(e_path);
        e_player SetOrigin((-213, 4250, 960));
        e_player zm_weapons::weapon_give(GetWeapon("smg_fastfire_t8"));
    }

    thread zombie_open_sesame();
    wait 7;
    level flag::clear("spawn_zombies");
    goto_round(9);
}

berths_walk_monitor(e_path)
{
    self endon("disconnect");
    for (;;) {
        while (!self IsTouching(e_path)) {
            waitframe(1);
        }
        self IPrintLnBold("Entered Path");
        while (self IsTouching(e_path)) {
            waitframe(1);
        }
        self IPrintLnBold("Left Path");
    }
}