// 0 - mid, 1 - far, 2 - close
zm_mansion_ww_lvl3_quest_init()
{
    settings = level.patch_settings.settings.zm_mansion.ww_quest.dig;
    a_dig_locs_enabled = [];
    a_dig_locs = struct::get_array("ww_lvl3_part_3_pos");
    if (settings.mid) {
        a_dig_locs_enabled[a_dig_locs_enabled.size] = a_dig_locs[0];
    }
    if (settings.far) {
        a_dig_locs_enabled[a_dig_locs_enabled.size] = a_dig_locs[1];
    }
    if (settings.close) {
        a_dig_locs_enabled[a_dig_locs_enabled.size] = a_dig_locs[2];
    }
    if (!a_dig_locs_enabled.size) {
        return;
    }
    foreach (n_index, dig_loc in a_dig_locs) {
        if (dig_loc.var_3dd3b66e === 1) {
            dig_loc.var_3dd3b66e = undefined;
            array::random(a_dig_locs_enabled).var_3dd3b66e = 1;
            return;
        }
    }
}