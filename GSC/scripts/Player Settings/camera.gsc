camera_set_position()
{
    pos = (0, 0, 0);
    angles = (0, 0, 0);
    for(;;) {
        self waittill("camera_set_position");
        pos = self GetTagOrigin("j_head");
        angles = self GetPlayerAngles();
        self CameraSetPosition(pos, angles);
        self IPrintLnBold("Updated Camera Position");
    }
}

camera_toggle()
{
    camera_active = false;
    for(;;) {
        self waittill("camera_toggle");
        camera_active = !camera_active;
        self CameraActivate(camera_active);
        self IPrintLnBold("Camera Toggled");
    }
}

noclip_bind()
{
    self endon(#"spawned_player", #"disconnect", #"bled_out");
    level endon(#"end_game", #"game_ended");
    self notify(#"stop_player_out_of_playable_area_monitor");
	self unlink();
    if(isdefined(self.originObj)) {
        self.originObj delete();
    }
	for (;;) {
		self waittill("noclip_toggle");
		self thread player_noclip();
		self waittill("noclip_toggle");
		self notify("noclip_end");
		self unlink();
		if(isdefined(self.originObj)) {
			self.originObj delete();
		}
		self iprintln("^1Disabled");
	}
}

player_noclip()
{
	self endon("noclip_end");
	self.originObj = spawn("script_origin", self.origin, 1);
	self.originObj.angles = self.angles;
	self PlayerLinkTo(self.originObj, undefined);
	self iprintln("^2Noclip Enabled");
	self iprintln("[{+breath_sprint}] to fly");
	self enableweapons();
	for (;;) {
		if(self SprintButtonPressed()) {
			normalized = AnglesToForward(self GetPlayerAngles());
			scaled = vectorScale(normalized, 60);
			originpos = self.origin + scaled;
			self.originObj.origin = originpos;
		}
		waitframe(1);
	}
}