mini_boss_hud_add()
{
    if (!IsDefined(level.a_mini_bosses)) {
        level.a_mini_bosses = [];
        thread mini_boss_reorder();
    }
    level.a_mini_bosses[level.a_mini_bosses.size] = self;
    self.n_id = level.a_mini_bosses.size;
    LUINotifyEvent(#"mini_boss_health_toggle", 2, self.n_id, 1);
    LUINotifyEvent(#"mini_boss_health_update", 3, self.n_id, self.health, self.maxhealth);
    self thread mini_boss_hud_damage();
    self thread mini_boss_hud_death();
}

mini_boss_reorder()
{
    for (;;) {
        level waittill("mini_boss_death");
        for (n_index = 0; n_index < level.a_mini_bosses.size; n_index++) {
            ai_mini_boss = level.a_mini_bosses[n_index];
            ai_mini_boss.n_id = n_index + 1;
            LUINotifyEvent(#"mini_boss_health_update", 4, ai_mini_boss.n_id, ai_mini_boss.health, ai_mini_boss.maxhealth, 1);
        }
        LUINotifyEvent(#"mini_boss_health_toggle", 2, n_index + 1, 0);
    }
}

mini_boss_hud_damage()
{
    self endon("death");
    for (;;) {
        self waittill("damage");
        LUINotifyEvent(#"mini_boss_health_update", 3, self.n_id, self.health, self.maxhealth);
    }
}

mini_boss_hud_death()
{
    self waittill("death");
    ArrayRemoveValue(level.a_mini_bosses, self);
    level notify("mini_boss_death");
}