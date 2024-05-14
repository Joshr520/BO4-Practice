#include scripts\core_common\struct;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\music_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\values_shared;
#include scripts\core_common\ai_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\bots\bot_util;
#include scripts\core_common\bots\bot;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\ai\systems\destructible_character;

#include scripts\zm_common\zm_game_module;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_zonemgr;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_utility_zstandard;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_bgb_pack;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\ai\zm_ai_utility;

//#include scripts\zm\zm_hms_util;

#include script_3819e7a1427df6d2; // aiutility
#include script_2c5daa95f8fec03c;
#include script_ab862743b3070a; // zombie_dog_util
#include script_742a29771db74d6f; // zm_arcade_timer

#namespace bo4_practice;

//required
autoexec __init__sytem__()
{
	system::register("bo4_practice", &__init__, undefined, undefined);
    level.var_58bc5d04 = GetTime();
}

//required
__init__()
{
    init_clientfields();
    init_flags();
    thread init_settings();
    callback::on_start_gametype(&init);
    callback::on_connect(&on_connect);
    callback::on_spawned(&on_spawned);
}

init_clientfields()
{
    clientfield::register("world", "shield_practice_enable", 1, 2, "int");
}

init_flags()
{
    level flag::init("practice_enabled");
}

init_settings()
{
    ShieldLog("GSC Loading");
    level.patch_settings = ShieldFromJson("bo4_practice");
    n_result = 2;
    if (!IsDefined(level.patch_settings) || (util::get_map_name() != level.patch_settings.map && level.patch_settings.map != "all") || !level.patch_settings.enabled) {
        n_result = 1;
        ShieldLog("Patch Not Enabled/Incorrect Settings");
    }
    else {
        ShieldLog("--------------JSON DATA--------------");
        ShieldLog("enabled: " + level.patch_settings.enabled);
        ShieldLog("map: " + level.patch_settings.map);
        ShieldLog("patch: " + level.patch_settings.patch);
        ShieldLog("timer: " + level.patch_settings.timer);
        ShieldLog("zombie_counter: " + level.patch_settings.zombie_counter);
        ShieldLog("--------------JSON DATA--------------");
    }

    level.b_godmode_enabled = 0;
    level.b_infinite_ammo_enabled = 0;
    
    if (n_result === 2) {
        level flag::set("practice_enabled");
    }

    while (!level flag::exists("start_zombie_round_logic")) {
        waitframe(1);
    }
    level flag::wait_till("start_zombie_round_logic");
    clientfield::set("shield_practice_enable", n_result);
    if (n_result === 1) {
        level notify("shield_practice_kill");
    }
}