zm_zodt8_practice()
{
    switch (level.patch_settings.patch) {
        case "free_kraken": {
            self thread zm_zodt8_free_kraken_helper();
            break;
        }
        default: {
            return;
        }
    }
}