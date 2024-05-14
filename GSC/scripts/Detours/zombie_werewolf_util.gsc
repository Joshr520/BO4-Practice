detour zm_ai_werewolf<scripts\zm\ai\zm_ai_werewolf.gsc>::function_eaceec8b() {
    self [[ @zm_ai_werewolf<scripts\zm\ai\zm_ai_werewolf.gsc>::function_eaceec8b ]]();
    if (IsDefined(level.patch_settings) && level.patch_settings.enabled) {
        if (level.patch_settings.settings.zm_mansion.enemy_markers === 1) {
            self thread add_new_objective(#"hash_423a75e2700a53ab");
        }
        self thread mini_boss_hud_add();
    }
}