perkaholic()
{
    self thread [[ @zm_bgb_perkaholic<scripts\zm_common\bgbs\zm_bgb_perkaholic.gsc>::activation ]]();
}

activate_perk_slot(n_slot)
{
    self thread zm_perks::function_9bdf581f(self.var_c27f1e90[n_slot], n_slot);
}