// 0 - danu, 1 - cellar, 2 - master
zm_mansion_wicker_ghost_init()
{
    settings = level.patch_settings.settings.zm_mansion.lockdowns.ghosts;
    a_ghost_locs_disabled = [];
    a_ghost_locs = struct::get_array("stick_guide_loc");
    if (!settings.danu) {
        a_ghost_locs_disabled[a_ghost_locs_disabled.size] = a_ghost_locs[0];
    }
    if (!settings.cellar) {
        a_ghost_locs_disabled[a_ghost_locs_disabled.size] = a_ghost_locs[1];
    }
    if (!settings.master) {
        a_ghost_locs_disabled[a_ghost_locs_disabled.size] = a_ghost_locs[2];
    }
    if (!a_ghost_locs_disabled.size) {
        return;
    }
    foreach (ghost_loc in a_ghost_locs_disabled) {
        ghost_loc struct::delete();
    }
}