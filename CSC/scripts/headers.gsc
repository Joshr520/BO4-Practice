#include scripts\core_common\struct.csc;
#include scripts\core_common\callbacks_shared.csc;
#include scripts\core_common\clientfield_shared.csc;
#include scripts\core_common\math_shared.csc;
#include scripts\core_common\system_shared.csc;
#include scripts\core_common\util_shared.csc;
#include scripts\core_common\array_shared.csc;
#include scripts\core_common\flag_shared.csc;
#include scripts\core_common\scene_shared.csc;

#namespace bo4_practice;

autoexec __init__sytem__()
{
	system::register("bo4_practice", &__init__, undefined, undefined);
}

__init__()
{
    init_clientfields();
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

init_clientfields()
{
    clientfield::register("world", "shield_practice_enable", 1, 2, "int", &shield_practice_enable, 0, 0);
}