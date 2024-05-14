get_player_by_name(player_name)
{
    foreach (e_player in GetPlayers()) {
        ShieldLog(ToLower(e_player.name) + " == " + ToLower(player_name));
        if (ToLower(e_player.name) == ToLower(player_name)) {
            ShieldLog("Player Found By Name");
            return e_player;
        }
    }
    return undefined;
}

get_player_by_character_slot(n_character_slot)
{
    
    foreach (e_player in GetPlayers()) {
        ShieldLog("Character Index: " + e_player.characterindex);
        switch (e_player.characterindex) {
            case 1:
            case 7:
            case 10:
            case 15:
            case 18:
            case 22:
            case 26: {
                if (n_character_slot == 1) {
                    return e_player;
                }
                break;
            }
            case 2:
            case 6:
            case 12:
            case 13:
            case 17:
            case 21:
            case 25: {
                if (n_character_slot == 2) {
                    return e_player;
                }
                break;
            }
            case 4:
            case 5:
            case 11:
            case 16:
            case 19:
            case 23:
            case 28: {
                if (n_character_slot == 3) {
                    return e_player;
                }
                break;
            }
            case 3:
            case 8:
            case 9:
            case 14:
            case 20:
            case 24:
            case 27: {
                if (n_character_slot == 4) {
                    return e_player;
                }
                break;
            }
            default: {
                break;
            }
        }
    }
    return undefined;
}