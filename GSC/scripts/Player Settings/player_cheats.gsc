godmode()
{
    level notify("godmode_request");
    level endon("godmode_request");

    if (level.b_godmode_enabled !== 1) {
        level endon("godmode_end");
        level.b_godmode_enabled = 1;
        self IPrintLnBold("Godmode Enabled");
        for (;;) {
            self EnableInvulnerability();
            wait 0.25;
        }
    }
    else {
        level notify("godmode_end");
        level.b_godmode_enabled = 0;
        self IPrintLnBold("Godmode Disabled");
        self DisableInvulnerability();
    }
}

infinite_ammo()
{
    level notify("infinite_ammo_request");
    level endon("infinite_ammo_request");
    if (level.b_infinite_ammo_enabled !== 1) {
        level endon("infinite_ammo_end");
        level.b_infinite_ammo_enabled = 1;
        self IPrintLnBold("Infinite Ammo Enabled");
        for (;;) {
            weapon  = self GetCurrentWeapon();
            offhand = self GetCurrentOffhand();
            if(IsDefined(weapon) && weapon != level.weaponNone) {
                self SetWeaponAmmoClip(weapon, 1337);
                self GiveMaxAmmo(weapon);
                self GiveMaxAmmo(offhand);
                self GadgetPowerSet(2, 100);
                self GadgetPowerSet(1, 100);
                self GadgetPowerSet(0, 100);
            }
            if (self GadgetIsActive(0) || self GadgetIsActive(1) || self GadgetIsActive(2)) {
                waitframe(1);
            }
            else {
                self waittill(#"weapon_fired", #"grenade_fire", #"missile_fire", #"weapon_change", #"melee", #"hero_weapon_activated");
            }
        }
    }
    else {
        level notify("infinite_ammo_end");
        level.b_infinite_ammo_enabled = 0;
        self IPrintLnBold("Infinite Ammo Disabled");
    }
}