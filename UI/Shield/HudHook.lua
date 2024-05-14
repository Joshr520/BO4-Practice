local DebugPrint = function(text)
	Engine[@"PrintInfo"](0, "LUA Debug Print: " .. text)
end

local SetupHudElementVisibilityStates = function(element, menu, controller)
	element:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				if Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
				and Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_emp_active"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_game_ended"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
				and not Engine[@"isvisibilitybitset"](controller, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) then
					return false
				else
					return true
				end
			end
		}
	})

	local Model = Engine[@"GetModelForController"](controller)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]
		})
	end, false)
	element:subscribeToModel(Model["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(ModelRef)
		menu:updateElementState(element, {
			name = "model_validation",
    		menu = menu,
    		controller = controller,
    		modelValue = ModelRef:get(),
    		modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]
		})
	end, false)
end

CoD.HealthBarMeter = InheritFrom(LUI.UIElement)
CoD.HealthBarMeter.new = function()
	local self = LUI.UIElement.new()
	self:setClass(CoD.CommonWipeMeterWithGlow)
	self.id = "CommonWipeMeterWithGlow"
	self.soundSet = "none"

	self.Meter = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self.Meter:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
	self.Meter:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
	self.Meter:setShaderVector(0, 1, 0, 0, 0)
	self.Meter:setShaderVector(1, 0, 0, 0, 0)
	self.Meter:setShaderVector(2, 1, 0, 0, 0)
	self.Meter:setShaderVector(3, 0, 0, 0, 0)
	self.Meter:setShaderVector(4, 0, 0, 0, 0)
	self.Meter:setRGB(0, 0, 0)
	self:addElement(self.Meter)

	self.MeterAdd = LUI.UIImage.new(0, 1, 0, 0, 0.22, 0.78, 0, 0)
	self.MeterAdd:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
	self.MeterAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1910274CA3518744"))
	self.MeterAdd:setShaderVector(0, 1, 0, 0, 0)
	self.MeterAdd:setShaderVector(1, 0, 0, 0, 0)
	self.MeterAdd:setShaderVector(2, 1, 0, 0, 0)
	self.MeterAdd:setShaderVector(3, 0, 0, 0, 0)
	self.MeterAdd:setShaderVector(4, 0, 0, 0, 0)
	self.MeterAdd:setRGB(1, 0, 0)
	self:addElement(self.MeterAdd)

	self.MeterSubtract = LUI.UIImage.new(0, 1, 0, 0, 0.22, 0.78, 0, 0)
	self.MeterSubtract:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
	self.MeterSubtract:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1910274CA3518744"))
	self.MeterSubtract:setShaderVector(0, 1, 0, 0, 0)
	self.MeterSubtract:setShaderVector(1, 0, 0, 0, 0)
	self.MeterSubtract:setShaderVector(2, 1, 0, 0, 0)
	self.MeterSubtract:setShaderVector(3, 0, 0, 0, 0)
	self.MeterSubtract:setShaderVector(4, 0, 0, 0, 0)
	self.MeterSubtract:setRGB(1, 0, 0)
	self.MeterSubtract:setAlpha(0.25)
	self.MeterSubtract:setZRot(180)
	self:addElement(self.MeterSubtract)

	return self
end

CoD.MiniBossHealthBar = InheritFrom(LUI.UIElement)
CoD.MiniBossHealthBar.new = function(menu, controller, ID)
	local self = LUI.UIElement.new()
	self.ID = ID

	local MiniBossIcons = {
		["zm_mansion"] = @"uie_werewolf_splash"
	}

	self.HealthBarIcon = LUI.UIImage.new()
	self.HealthBarIcon:setLeftRight(true, false, 0, 80)
	self.HealthBarIcon:setTopBottom(true, false, 0, 70)
	self.HealthBarIcon:setImage(RegisterImage(MiniBossIcons[Engine[@"getcurrentmap"]()]))
	self.HealthBarIcon:setAlpha(0)
	self:addElement(self.HealthBarIcon)

	self.HealthBar = CoD.HealthBarMeter.new()
	self.HealthBar:setLeftRight(true, false, 70, 200)
	self.HealthBar:setTopBottom(true, false, 10, 50)
	self.HealthBar:setAlpha(0)
	self:addElement(self.HealthBar)

	self.HealthBarText = LUI.UIText.new()
	self.HealthBarText:setText("")
	self.HealthBarText:setLeftRight(true, false, 70, 200)
	self.HealthBarText:setTopBottom(true, false, 50, 65)
	self.HealthBarText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(self.HealthBarText)

	self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
		if CoD.ModelUtility.IsParamModelEqualToHashString(ModelRef, @"mini_boss_health_toggle") then
			local scriptData = CoD.GetScriptNotifyData(ModelRef)
			if scriptData[1] == self.ID  then
				if scriptData[2] == 1 then
					self.HealthBarIcon:setAlpha(1)
					self.HealthBar:setAlpha(1)
				else
					self.HealthBarIcon:setAlpha(0)
					self.HealthBar:setAlpha(0)
					self.HealthBarText:setText("")
				end
			end
		end
	end)

	self.HealthBar:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
		if CoD.ModelUtility.IsParamModelEqualToHashString(ModelRef, @"mini_boss_health_update") then
			local scriptData = CoD.GetScriptNotifyData(ModelRef)
			if scriptData[1] == self.ID and scriptData[2] and scriptData[3] then
				local HealthPercentage = scriptData[2] / scriptData[3]
				if HealthPercentage ~= 1 and scriptData[4] ~= 1 then
					self.HealthBar.MeterAdd:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
					self.HealthBar.MeterSubtract:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				elseif scriptData[4] == 1 then
					self.HealthBar.MeterAdd:completeAnimation()
					self.HealthBar.MeterSubtract:completeAnimation()
				end
				self.HealthBar.MeterAdd:setShaderVector(0, HealthPercentage, 0, 0, 0)
				self.HealthBar.MeterSubtract:setShaderVector(0, 1 - HealthPercentage, 0, 0, 0)
				self.HealthBarText:setText("^7" .. tostring(scriptData[2]) .. "^1/^7" .. tostring(scriptData[3]))
			end
		end
	end)

	self:subscribeToModel(Engine[@"CreateModel"](Engine[@"GetGlobalModel"](), "fastRestart"), function(ModelRef)
		self.HealthBarIcon:setAlpha(0)
		self.HealthBar:setAlpha(0)
		self.HealthBarText:setText("")
	end, false)

	SetupHudElementVisibilityStates(self, menu, controller)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

	return self
end

CoD.MiniBossHealthBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(3)
			element.HealthBarIcon:setAlpha(1)
			element.clipFinished(element.HealthBarIcon)
			element.HealthBar:completeAnimation()
			element.HealthBar:setAlpha(1)
			element.clipFinished(element.HealthBar)
			element.HealthBarText:setAlpha(1)
			element.clipFinished(element.HealthBarText)
		end
	},
	Hidden = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(3)
			element.HealthBarIcon:setAlpha(0)
			element.clipFinished(element.HealthBarIcon)
			element.HealthBar:completeAnimation()
			element.HealthBar:setAlpha(0)
			element.clipFinished(element.HealthBar)
			element.HealthBarText:setAlpha(0)
			element.clipFinished(element.HealthBarText)
		end
	}
}

CoD.MiniBossHealthBar.__onClose = function(element)
	element.HealthBarIcon:close()
	element.HealthBar:close()
	element.HealthBarText:close()
end

CoD.BossHealthBar = InheritFrom(LUI.UIElement)
CoD.BossHealthBar.new = function(menu, controller)
	local self = LUI.UIElement.new()
	self:setTopBottom(true, false, 10, 80)

	local BossNames = {
		["zm_mansion"] = "Werewolf Boss",
		["zm_zodt8"] = "Eye of Odin"
	}

	self.HealthBarName = LUI.UIText.new()
	self.HealthBarName:setText(BossNames[Engine[@"getcurrentmap"]()])
	self.HealthBarName:setAlpha(0)
	self.HealthBarName:setLeftRight(true, true, 0, 0)
	self.HealthBarName:setTopBottom(true, false, 0, 25)
	self.HealthBarName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(self.HealthBarName)

	self.HealthBar = CoD.HealthBarMeter.new()
	self.HealthBar.MeterAdd:setTopBottom(0.1, 0.9, 0, 0)
	self.HealthBar.MeterSubtract:setTopBottom(0.1, 0.9, 0, 0)
	self.HealthBar:setLeftRight(true, true, 0, 0)
	self.HealthBar:setTopBottom(true, true, 10, 0)
	self.HealthBar:setAlpha(0)
	self:addElement(self.HealthBar)

	self.HealthBarText = LUI.UIText.new()
	self.HealthBarText:setText("")
	self.HealthBarText:setLeftRight(true, true, 0, 0)
	self.HealthBarText:setTopBottom(true, false, 35, 55)
	self.HealthBarText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(self.HealthBarText)

	self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
		if CoD.ModelUtility.IsParamModelEqualToHashString(ModelRef, @"boss_health_toggle") then
			local scriptData = CoD.GetScriptNotifyData(ModelRef)
			if scriptData and scriptData[1] == 1 then
				self.HealthBarName:setAlpha(1)
				self.HealthBar:setAlpha(1)
			else
				self.HealthBarName:setAlpha(0)
				self.HealthBar:setAlpha(0)
				self.HealthBarText:setText("")
			end
		end
	end)

	self.HealthBar:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
		if CoD.ModelUtility.IsParamModelEqualToHashString(ModelRef, @"boss_health_update") then
			local scriptData = CoD.GetScriptNotifyData(ModelRef)
			if scriptData[1] and scriptData[2] then
				local HealthPercentage = scriptData[1] / scriptData[2]
				self.HealthBar.MeterAdd:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				self.HealthBar.MeterSubtract:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				self.HealthBar.MeterAdd:setShaderVector(0, HealthPercentage, 0, 0, 0)
				self.HealthBar.MeterSubtract:setShaderVector(0, 1 - HealthPercentage, 0, 0, 0)
				self.HealthBarText:setText("^7" .. tostring(scriptData[1]) .. "^1/^7" .. tostring(scriptData[2]))
			end
		end
	end)

	self:subscribeToModel(Engine[@"CreateModel"](Engine[@"GetGlobalModel"](), "fastRestart"), function(ModelRef)
		self.HealthBarName:setAlpha(0)
		self.HealthBar:setAlpha(0)
		self.HealthBarText:setText("")
	end, false)

	SetupHudElementVisibilityStates(self, menu, controller)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

	return self
end

CoD.BossHealthBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(3)
			element.HealthBarName:setAlpha(1)
			element.clipFinished(element.HealthBarName)
			element.HealthBar:completeAnimation()
			element.HealthBar:setAlpha(1)
			element.clipFinished(element.HealthBar)
			element.HealthBarText:setAlpha(1)
			element.clipFinished(element.HealthBarText)
		end
	},
	Hidden = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(3)
			element.HealthBarName:setAlpha(0)
			element.clipFinished(element.HealthBarName)
			element.HealthBar:completeAnimation()
			element.HealthBar:setAlpha(0)
			element.clipFinished(element.HealthBar)
			element.HealthBarText:setAlpha(0)
			element.clipFinished(element.HealthBarText)
		end
	}
}

CoD.BossHealthBar.__onClose = function(element)
	element.HealthBarName:close()
	element.HealthBar:close()
	element.HealthBarText:close()
end

CoD.ZombieCounter = InheritFrom(LUI.UIElement)
CoD.ZombieCounter.new = function(menu, controller)
	local self = LUI.UIElement.new()
	self:setClass(CoD.ZombieCounter)
	self.id = "ZombieCounter"
	self.soundSet = "deafult"
	self:setLeftRight(true, true, 0, 0)
	self:setTopBottom(true, true, 0, 0)
	menu:addElementToPendingUpdateStateList(self)

	self.Text = LUI.UIText.new()
	self.Text:setText("")
	self.Text:setLeftRight(true, true, 0, 0)
	self.Text:setTopBottom(true, false, 5, 30)
	self.Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self.Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self.Text:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
        if CoD.ModelUtility.IsParamModelEqualToHashString(ModelRef, @"zombie_counter") then
			local scriptData = CoD.GetScriptNotifyData(ModelRef)
			if not scriptData then
				self.Text:setText("")
			else
				self.Text:setText("^1Zombies: ^5" .. tostring(scriptData[1]) .. " ^1(^5" .. tostring(scriptData[2]) .. " ^1remaining)")
			end
        end
    end)
    self:addElement(self.Text)

    self:subscribeToModel(Engine[@"CreateModel"](Engine[@"GetGlobalModel"](), "fastRestart"), function(ModelRef)
		self.Text:setText("")
	end, false)

    SetupHudElementVisibilityStates(self, menu, controller)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

    return self
end

CoD.ZombieCounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(1)
			element.Text:setAlpha(1)
			element.clipFinished(element.Text)
		end
	},
	Hidden = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(1)
			element.Text:setAlpha(0)
			element.clipFinished(element.Text)
		end
	}
}

CoD.ZombieCounter.__onClose = function(element)
	element.Text:close()
end

CoD.PatchEnabled = InheritFrom(LUI.UIElement)
CoD.PatchEnabled.new = function(menu, controller)
	local self = LUI.UIElement.new()
	self:setClass(CoD.PatchEnabled)
	self.id = "PatchEnabled"
	self.soundSet = "deafult"
	self:setLeftRight(true, false, 810, 1110)
	self:setTopBottom(false, true, -50, -5)
	menu:addElementToPendingUpdateStateList(self)

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight(true, true, 0, 0)
	self.Background:setTopBottom(true, true, 0, 0)
	self.Background:setRGB(0.13, 0.12, 0.12)
	self.Background:setAlpha(0.9)
	self:addElement(self.Background)

	self.Logo = LUI.UIImage.new()
	self.Logo:setLeftRight(true, false, 2.5, 42.5)
	self.Logo:setTopBottom(true, false, 2.5, 42.5)
	self.Logo:setImage(RegisterImage(@"hash_6D50708E11EDBD06"))
	self.Logo:setRGB(1, 0.5, 0.1)
	self:addElement(self.Logo)

	self.Text = LUI.UIText.new()
	self.Text:setLeftRight(true, true, 55, 0)
	self.Text:setTopBottom(true, false, 7.5, 37.5)
	self.Text:setText("^1Practice Patch ON")
	self:addElement(self.Text)

	SetupHudElementVisibilityStates(self, menu, controller)

	self:mergeStateConditions({
		{
			stateName = "PatchEnabled",
			condition = function(menu, element, event)
				local ModelRef = Engine[@"GetModel"](Engine[@"GetModelForController"](controller), "PatchEnabled")
				if not ModelRef then
					return false
				end
				local Value = Engine[@"GetModelValue"](ModelRef)
				if Value == 1 then
					return true
				else
					return false
				end
			end
		}
	})

	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

	return self
end

CoD.PatchEnabled.__clipsPerState = {
	PatchEnabled = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(3)
			element.Background:setAlpha(0.9)
			element.clipFinished(element.Background)
			element.Logo:setAlpha(1)
			element.clipFinished(element.Logo)
			element.Text:setAlpha(1)
			element.clipFinished(element.Text)
		end
	},
	Hidden = {
		DefaultClip = function(element, controller)
			element:setupElementClipCounter(3)
			element.Background:setAlpha(0)
			element.clipFinished(element.Background)
			element.Logo:setAlpha(0)
			element.clipFinished(element.Logo)
			element.Text:setAlpha(0)
			element.clipFinished(element.Text)
		end
	}
}

local SetupMenuResponseModel = function(menu, controller, MenuName, ModelName, ResetValue)
	menu:subscribeToModel(Engine[@"GetModel"](Engine[@"GetModelForController"](controller), MenuName .. "." .. ModelName), function(ModelRef)
		local Value = Engine[@"GetModelValue"](ModelRef)
		if Value == 0 or Value == "" then
			return
		end
		local IsNumber = type(Value) == "number"
		if ResetValue then
			if IsNumber then
				Engine[@"SetModelValue"](ModelRef, 0)
			else
				Engine[@"SetModelValue"](ModelRef, "")
			end
		end
		DebugPrint("SendCustomMenuResponse: " .. MenuName .. " " .. ModelName .. " " .. tostring(Value))
		if IsNumber then
			CoD.BaseUtility.SendCustomMenuResponse(controller, MenuName, ModelName, Value)
		else
			CoD.BaseUtility.SendCustomMenuResponse(controller, MenuName, Value, 0)
		end
	end)
end

LUI.createMenu["T7Hud_" .. Engine[@"getcurrentmap"]()] = function(controller) 
	local self = LUI.createMenu.T7Hud_zm_factory(controller)
	DebugPrint("Injecting custom menu")

	self.ZombieCounter = CoD.ZombieCounter.new(self, controller)
	self:addElement(self.ZombieCounter)

	self.MiniBossHealthBar1 = CoD.MiniBossHealthBar.new(self, controller, 1)
	self.MiniBossHealthBar1:setLeftRight(true, false, 360, 560)
	self.MiniBossHealthBar1:setTopBottom(true, false, 10, 110)
	self:addElement(self.MiniBossHealthBar1)

	self.MiniBossHealthBar2 = CoD.MiniBossHealthBar.new(self, controller, 2)
	self.MiniBossHealthBar2:setLeftRight(true, false, 560, 760)
	self.MiniBossHealthBar2:setTopBottom(true, false, 10, 110)
	self:addElement(self.MiniBossHealthBar2)

	self.MiniBossHealthBar3 = CoD.MiniBossHealthBar.new(self, controller, 3)
	self.MiniBossHealthBar3:setLeftRight(true, false, 760, 960)
	self.MiniBossHealthBar3:setTopBottom(true, false, 10, 110)
	self:addElement(self.MiniBossHealthBar3)

	self.MiniBossHealthBar4 = CoD.MiniBossHealthBar.new(self, controller, 4)
	self.MiniBossHealthBar4:setLeftRight(true, false, 960, 1160)
	self.MiniBossHealthBar4:setTopBottom(true, false, 10, 110)
	self:addElement(self.MiniBossHealthBar4)

	self.BossHealthBar = CoD.BossHealthBar.new(self, controller)
	self.BossHealthBar:setLeftRight(true, true, 360, -360)
	self:addElement(self.BossHealthBar)

	self.PatchMessage = CoD.PatchEnabled.new(self, controller)
	self:addElement(self.PatchMessage)

	SetupMenuResponseModel(self, controller, "ClientToServer", "points", false)
	SetupMenuResponseModel(self, controller, "ClientToServer", "specialist_level", false)
	SetupMenuResponseModel(self, controller, "ClientToServer", "start_settings", false)
	SetupMenuResponseModel(self, controller, "ClientToServer", "keybind_message", true)

	return self
end

local SetClientToServerValues = function(controller, List, ModelValue)
	for Index, Value in ipairs(List) do
		local ModelRef = Engine[@"GetModel"](Engine[@"GetModelForController"](controller), Value)
		if ModelRef == nil then
			ModelRef = Engine[@"CreateModel"](Engine[@"GetModelForController"](controller), Value)
		end
		Engine[@"SetModelValue"](ModelRef, ModelValue)
	end
end

local HUD_FirstSnapshot_Common_Original = HUD_FirstSnapshot_Common
function HUD_FirstSnapshot_Common(f58_arg0, f58_arg1)
	DebugPrint("HUD_FirstSnapshot_Common")
	CoD.SubtitleUtility.ClearSubtitleModels(f58_arg1.controller)
	local ClientToServerIntModels = {
		"ClientToServer.points",
		"ClientToServer.specialist_level",
		"ClientToServer.start_settings"
	}
	local ClientToServerStringModels = {
		"ClientToServer.keybind_message"
	}
	SetClientToServerValues(f58_arg1.controller, ClientToServerIntModels, 0)
	SetClientToServerValues(f58_arg1.controller, ClientToServerStringModels, "")
	Engine[@"SetModelValue"](Engine[@"CreateModel"](Engine[@"GetModelForController"](controller), "PatchEnabled"), 0)
	HUD_FirstSnapshot_Common_Original(f58_arg0, f58_arg1)
end