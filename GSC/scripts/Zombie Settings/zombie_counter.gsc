zombie_counter_run()
{
    n_old_count = 0;
    n_old_remaining = 0;

    while (!IsDefined(level.zombie_team)) {
        waitframe(1);
    }

    for (;;) {
        n_count = 0;
        b_notify = false;
        a_ai_zombies = GetAITeamArray(level.zombie_team);

        foreach (ai_zombie in a_ai_zombies) {
            if (ai_zombie.ignore_enemy_count === 1) {
                continue;
            }
            n_count++;
        }
        if (n_count != n_old_count) {
            n_old_count = n_count;
            b_notify = true;
        }
        if (level.zombie_total != n_old_remaining) {
            n_old_remaining = level.zombie_total;
            b_notify = true;
        }
        if (b_notify) {
            LUINotifyEvent(#"zombie_counter", 2, n_old_count, n_old_remaining);
        }
        waitframe(1);
    }
}