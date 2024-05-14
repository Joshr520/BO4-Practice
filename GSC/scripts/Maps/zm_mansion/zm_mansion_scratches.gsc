// 0 - dining, 1 - library, 2 - danu, 3 - master, 4 - cellar, 5 - main, 6 - billiards
zm_mansion_scratches_init()
{
    settings = level.patch_settings.settings.zm_mansion.lockdowns.scratches;
    a_symbol_locs_disabled = [];
    a_symbol_locs = struct::get_array("symbol_combo_loc");
    if (!settings.dining) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[0];
    }
    if (!settings.library) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[1];
    }
    if (!settings.danu) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[2];
    }
    if (!settings.master) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[3];
    }
    if (!settings.cellar) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[4];
    }
    if (!settings.main) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[5];
    }
    if (!settings.billiards) {
        a_symbol_locs_disabled[a_symbol_locs_disabled.size] = a_symbol_locs[6];
    }
    if (!a_symbol_locs_disabled.size) {
        return;
    }
    foreach (symbol_loc in a_symbol_locs_disabled) {
        symbol_loc struct::delete();
    }
}