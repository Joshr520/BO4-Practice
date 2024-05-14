autoexec init_keys()
{
    level.wait_keys = [];
    level.wait_keys["F1"] = 0x70;
    level.wait_keys["F2"] = 0x71;
    level.wait_keys["F3"] = 0x72;
    level.wait_keys["F4"] = 0x73;
    level.wait_keys["F5"] = 0x74;
    level.wait_keys["F6"] = 0x75;
    level.wait_keys["F7"] = 0x76;
    level.wait_keys["F8"] = 0x77;
    level.wait_keys["F9"] = 0x78;
    level.wait_keys["F10"] = 0x79;
    level.wait_keys["F11"] = 0x7A;
    level.wait_keys["F12"] = 0x7B;
    level.wait_keys["F13"] = 0x7C;
    level.wait_keys["F14"] = 0x7D;
    level.wait_keys["F15"] = 0x7E;
    level.wait_keys["F16"] = 0x7F;
    level.wait_keys["F17"] = 0x80;
    level.wait_keys["F18"] = 0x81;
    level.wait_keys["F19"] = 0x82;
    level.wait_keys["F20"] = 0x83;
    level.wait_keys["F21"] = 0x84;
    level.wait_keys["F22"] = 0x85;
    level.wait_keys["F23"] = 0x86;
    level.wait_keys["F24"] = 0x87;
    level.wait_keys["`"] = 0xC0;
    level.wait_keys["-"] = 0xBD;
    level.wait_keys["="] = 0xBB;
    level.wait_keys["["] = 0xDB;
    level.wait_keys["]"] = 0xDD;
    level.wait_keys["|"] = 0xDC;
    level.wait_keys[";"] = 0xBA;
    level.wait_keys["'"] = 0xDE;
    level.wait_keys[","] = 0xBC;
    level.wait_keys["."] = 0xBE;
    level.wait_keys["/"] = 0xBF;
    level.wait_keys["0"] = 0x30;
    level.wait_keys["1"] = 0x31;
    level.wait_keys["2"] = 0x32;
    level.wait_keys["3"] = 0x33;
    level.wait_keys["4"] = 0x34;
    level.wait_keys["5"] = 0x35;
    level.wait_keys["6"] = 0x36;
    level.wait_keys["7"] = 0x37;
    level.wait_keys["8"] = 0x38;
    level.wait_keys["9"] = 0x39;
    level.wait_keys["A"] = 0x41;
    level.wait_keys["B"] = 0x42;
    level.wait_keys["C"] = 0x43;
    level.wait_keys["D"] = 0x44;
    level.wait_keys["E"] = 0x45;
    level.wait_keys["F"] = 0x46;
    level.wait_keys["G"] = 0x47;
    level.wait_keys["H"] = 0x48;
    level.wait_keys["I"] = 0x49;
    level.wait_keys["J"] = 0x4A;
    level.wait_keys["K"] = 0x4B;
    level.wait_keys["L"] = 0x4C;
    level.wait_keys["M"] = 0x4D;
    level.wait_keys["N"] = 0x4E;
    level.wait_keys["O"] = 0x4F;
    level.wait_keys["P"] = 0x50;
    level.wait_keys["Q"] = 0x51;
    level.wait_keys["R"] = 0x52;
    level.wait_keys["S"] = 0x53;
    level.wait_keys["T"] = 0x54;
    level.wait_keys["U"] = 0x55;
    level.wait_keys["V"] = 0x56;
    level.wait_keys["W"] = 0x57;
    level.wait_keys["X"] = 0x58;
    level.wait_keys["Y"] = 0x59;
    level.wait_keys["Z"] = 0x5A;
}

wait_key(n_key)
{
    while (!KeyPressed(n_key)) {
        waitframe(1);
    }
}

set_model_on_keypress(model, n_value, str_response, str_keybind)
{
    n_key = level.wait_keys[str_keybind];
    if (!IsDefined(n_key)) {
        return;
    }
    for (;;) {
        wait_key(n_key);
        SetUIModelValue(model, str_response);
    }
}