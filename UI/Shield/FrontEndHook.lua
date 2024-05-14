CoD.PCUtility.UIMenuShortcutTable.ui_openCustomSettings = {
    menu = "CustomSettings",
    canOpen = function(controller)
        return true
    end
}

DataSources.CustomSettingsTabs = DataSourceHelpers.ListSetup("CustomSettingsTabs", function(arg1)
    return {
        {
            models = {
                tabName = @"shield/patch_settings",
                tabWidget = "CoD.PatchSettings"
            },
            properties = {
                tabId = "custom_settings"
            }
        },
        {
            models = {
                tabName = @"shield/custom_keybinds",
                tabWidget = "CoD.CustomKeyBinds",
            },
            properties = {
                tabId = "custom_settings"
            }
        }
    }
end, true)

DataSources.CustomKeyBindCategories = DataSourceHelpers.ListSetup("CustomKeyBindCategories", function(arg1)
    return {
        {
            models = {
                name = @"shield/custom_keybind_in_game",
                categoriyId = 1
            },
            properties = {}
        }
    }
end, true)

CoD.PatchSettings = InheritFrom(LUI.UIElement)
CoD.PatchSettings.__defaultWidth = 1920
CoD.PatchSettings.__defaultHeight = 1080
CoD.PatchSettings.new = function(menu, controller, anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    local self = LUI.UIElement.new(anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    self:setClass(CoD.PatchSettings)
    self.id = "PatchSettings"
    self.soundSet = "default"
    self.onlyChildrenFocusable = true
    self.anyChildUsesUpdateState = true

    self.Background = CoD.StartMenuOptionsBackground.new(menu, controller, 0, 1, 0, 0, 0, 1, 0, 0)
    self:addElement(self.Background)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end

    return self
end

CoD.PatchSettings.__onClose = function(element)
    element.Background:close()
end

CoD.CustomKeyBinds_TabContent = InheritFrom(LUI.UIElement)
CoD.CustomKeyBinds_TabContent.__defaultWidth = 1920
CoD.CustomKeyBinds_TabContent.__defaultHeight = 802
CoD.CustomKeyBinds_TabContent.new = function(menu, controller, anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    local self = LUI.UIElement.new(anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    self:setClass(CoD.CustomKeyBinds_TabContent)
    self.id = "CustomKeyBinds_TabContent"
    self.soundSet = "default"
    self.onlyChildrenFocusable = true
    self.anyChildUsesUpdateState = true
    menu:addElementToPendingUpdateStateList(self)

    return self
end

CoD.CustomKeyBinds = InheritFrom(LUI.UIElement)
CoD.CustomKeyBinds.__defaultWidth = 1920
CoD.CustomKeyBinds.__defaultHeight = 1080
CoD.CustomKeyBinds.new = function(menu, controller, anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    local self = LUI.UIElement.new(anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    self:setClass(CoD.CustomKeyBinds)
    self.id = "CustomKeyBinds"
    self.soundSet = "default"
    self.onlyChildrenFocusable = true
    self.anyChildUsesUpdateState = true

    self.Background = CoD.StartMenuOptionsBackground.new(menu, controller, 0, 1, 0, 0, 0, 1, 0, 0)
    self:addElement(self.Background)

    self.TabContent = CoD.CustomKeyBinds_TabContent.new(menu, controller, 0.5, 0.5, -960, 960, 0.5, 0.5, -360, 409)
    self:addElement(self.TabContent)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end

    return self
end

CoD.CustomKeyBinds.__onClose = function(element)
    element.Background:close()
end

CoD.CustomSettings_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.CustomSettings_SafeAreaContainer.__defaultWidth = 1920
CoD.CustomSettings_SafeAreaContainer.__defaultHeight = 1080
CoD.CustomSettings_SafeAreaContainer.new = function (menu, controller, anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    local self = LUI.UIElement.new(anchorLeft, anchorRight, offsetLeft, offsetRight, anchorTop, anchorBottom, offsetTop, offsetBottom)
    self:setClass(CoD.CustomSettings_SafeAreaContainer)
    self.id = "CustomSettings_SafeAreaContainer"
    self.soundSet = "default"
    self.onlyChildrenFocusable = true
    self.anyChildUsesUpdateState = true

    self.TabBacking = CoD.CommonTabBarBacking.new(menu, controller, 0, 1, 0, 0, 0, 0, 52, 89)
    self:addElement(self.TabBacking)

    self.tabs = CoD.CommonTabBar.new(menu, controller, 0.5, 0.5, -1650, 1650, 0, 0, 35.5, 97.5)
    self.tabs.Tabs.grid:setDataSource("CustomSettingsTabs")
    self.tabs.id = "tabs"
    self.tabs:registerEventHandler("list_active_changed", function (element, event)
        local f3_local0 = nil
        PlaySoundSetSound(self, "tab_changed")
        UpdateAllMenuButtonPrompts(self, controller)
        return f3_local0
    end)
    self.tabs:registerEventHandler("list_active_changed", function (element, event)
        return nil
    end)
    self:addElement(self.tabs)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)

    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end

    return self
end

CoD.CustomSettings_SafeAreaContainer.__onClose = function (element)
    element.TabBacking:close()
    element.tabs:close()
end

CoD.CustomSettings = InheritFrom(CoD.Menu)
LUI.createMenu.CustomSettings = function (controller, f1_arg1)
    local self = CoD.Menu.NewForUIEditor("CustomSettings", controller)

    self:setClass(CoD.CustomSettings)
    self.soundSet = "ChooseDecal"
    self:setOwner(controller)
    self:setLeftRight(0, 1, 0, 0)
    self:setTopBottom(0, 1, 0, 0)
    self:playSound("menu_open", controller)
    self.anyChildUsesUpdateState = true
    self:addElementToPendingUpdateStateList(self)

    self.Background = CoD.StartMenuOptionsBackground.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
    self.Background:setAlpha(0)
    self:addElement(self.Background)

    self.BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
    self.BlackBacking:setRGB(0, 0, 0)
    self.BlackBacking:setAlpha(0.5)
    self:addElement(self.BlackBacking)

    self.TabFrame = LUI.UIFrame.new(self, controller, 0, 0, false)
    self.TabFrame:setLeftRight(0, 1, 0, 0)
    self.TabFrame:setTopBottom(0, 1, 0, 0)
    self:addElement(self.TabFrame)

    self.GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
    self.GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_5C4B68D4F7C51908"):gsub("SOCIAL", "CUSTOM SETTINGS"))
    self.GenericMenuFrameIdentity:subscribeToGlobalModel(controller, "LobbyRoot", "lobbyTitle", function (model)
        local text = model:get()
        if text ~= nil then
            self.GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](text))
        end
    end)
    self:addElement(self.GenericMenuFrameIdentity)

    self.CustomSettingsSafeAreaContainer = CoD.CustomSettings_SafeAreaContainer.new(self, controller, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
    self.CustomSettingsSafeAreaContainer:registerEventHandler("menu_loaded", function (element, event)
        local f3_local0 = nil
        if element.menuLoaded then
            f3_local0 = element:menuLoaded(event)
        elseif element.super.menuLoaded then
            f3_local0 = element.super:menuLoaded(event)
        end
        SizeToSafeArea(element, controller)
        if not f3_local0 then
            f3_local0 = element:dispatchEventToChildren(event)
        end
        return f3_local0
    end)
    self:addElement(self.CustomSettingsSafeAreaContainer)

    self.TabFrame:linkToElementModel(self.CustomSettingsSafeAreaContainer.tabs.Tabs.grid, "tabWidget", true, function (model)
        local f4_local0 = model:get()
        if f4_local0 ~= nil then
            self.TabFrame:changeFrameWidget(f4_local0)
        end
    end)

    self:registerEventHandler("close_all_ingame_menus", function (self, event)
        local f11_local0 = nil
        if IsPC() then
            CoD.PCUtility.ShortcutMenuGoBack(self, controller)
        end
        if not f11_local0 then
            f11_local0 = self:dispatchEventToChildren(event)
        end
        return f11_local0
    end)
    self:registerEventHandler("occlusion_change", function (self, event)
        local f25_local0 = nil
        if self.OcclusionChange then
            f25_local0 = self:OcclusionChange(event)
        elseif self.super.OcclusionChange then
            f25_local0 = self.super:OcclusionChange(event)
        end
        if not f25_local0 then
            f25_local0 = self:dispatchEventToChildren(event)
        end
        return f25_local0
    end)

    self:AddButtonCallbackFunction(self, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_1E6DB407A2AF8B09"], nil, function (element, menu, controller, model)
        GoBack(self, controller)
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_1E6DB407A2AF8B09"], @"hash_0", nil, nil)
        return false
    end, false)
    self:AddButtonCallbackFunction(self, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_1805EFA15E9E7E5A"], nil, function (element, menu, controller, model)
        GoBack(self, controller)
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_1805EFA15E9E7E5A"], @"hash_370A9FDC87CD3D48", nil, nil)
        return true
    end, false)
    self:AddButtonCallbackFunction(self, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_4C083113BC81F23F"], nil, function (element, menu, controller, model)
        if AlwaysFalse() then
              return true
        else
              
        end
    end, function (element, menu, controller)
        if AlwaysFalse() then
            CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_4C083113BC81F23F"], @"hash_0", nil, nil)
            return false
        else
            return false
        end
    end, false)

    LUI.OverrideFunction_CallOriginalFirst(self, "goBack", function (element, controller)
        MenuUnhideFreeCursor(element, controller)
    end)
    self.TabFrame.id = "TabFrame"
    self.GenericMenuFrameIdentity:setModel(self.buttonModel, controller)
    self.GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
    self.CustomSettingsSafeAreaContainer.id = "CustomSettingsSafeAreaContainer"
    self:processEvent({
        name = "menu_loaded",
        controller = controller
    })
    self.__defaultFocus = self.TabFrame
    if CoD.isPC and (IsKeyboard(controller) or self.ignoreCursor) then
        self:restoreState(controller)
    end

    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
    if PostLoadFunc then
        PostLoadFunc(self, controller)
    end

    return self
end

CoD.CustomSettings.__onClose = function (element)
    element.TabFrame:close()
    element.Background:close()
    element.GenericMenuFrameIdentity:close()
    element.CustomSettingsSafeAreaContainer:close()
end

CoD.FooterButton_PersistentLeftContainer = InheritFrom(LUI.UIElement)
CoD.FooterButton_PersistentLeftContainer.__defaultWidth = 480
CoD.FooterButton_PersistentLeftContainer.__defaultHeight = 54
CoD.FooterButton_PersistentLeftContainer.new = function (menu, controller, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
    local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
    self:setAlignment(LUI.Alignment.Left)
    self:setClass(CoD.FooterButton_PersistentLeftContainer)
    self.id = "FooterButton_PersistentLeftContainer"
    self.soundSet = "default"
    self.onlyChildrenFocusable = CoD.isPC
    self.anyChildUsesUpdateState = true

    self.FooterButtonChat = CoD.FooterButton_Persistent.new(menu, controller, 0, 0, 0, 120, 0, 1, 0, 0)
    self.FooterButtonChat:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.MenuChatToggleShouldBeVisible(element, menu, controller)
            end
        }
    })
    self.FooterButtonChat:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonChat, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    self.FooterButtonChat:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller)["ChatGlobal.ChatAvailableInMenuEvent"], function (ModelRef)
        menu:updateElementState(self.FooterButtonChat, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "ChatGlobal.ChatAvailableInMenuEvent"
        })
    end, false)
    self.FooterButtonChat.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EE439D162567C89"))
    self.FooterButtonChat.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_68266B58948F0859"))
    self.FooterButtonChat.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21BBDD7D1B7CFB1B"))
    self.FooterButtonChat.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function ()
        self.FooterButtonChat.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_4925899529895C0B")))
    end

    self.FooterButtonChat.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
    self.FooterButtonChat:registerEventHandler("gain_focus", function (element, event)
        local f6_local0 = nil
        if element.gainFocus then
            f6_local0 = element:gainFocus(event)
        elseif element.super.gainFocus then
            f6_local0 = element.super:gainFocus(event)
        end
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
        return f6_local0
    end)
    menu:AddButtonCallbackFunction(self.FooterButtonChat, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        CoD.PCUtility.ToggleChatVisibility(controller)
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
        return false
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonChat, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        CoD.PCUtility.ToggleChatVisibility(controller)
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
        return false
    end, false)
    self:addElement(self.FooterButtonChat)

    self.FooterButtonFriends = CoD.FooterButton_Persistent.new(menu, controller, 0, 0, 120, 240, 0, 1, 0, 0)
    self.FooterButtonFriends:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                  return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.CanOpenFriends(controller, menu)
            end
        }
    })
    self.FooterButtonFriends:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonFriends, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    self.FooterButtonFriends.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2139903360C0166C"))
    self.FooterButtonFriends.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_308345F92F6F5B30"))
    self.FooterButtonFriends.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2D851B47994EA820"))
    self.FooterButtonFriends.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function ()
        self.FooterButtonFriends.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_521CC88215B8CABE")))
    end

    self.FooterButtonFriends.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
    self.FooterButtonFriends:registerEventHandler("gain_focus", function (element, event)
        local f14_local0 = nil
        if element.gainFocus then
            f14_local0 = element:gainFocus(event)
        elseif element.super.gainFocus then
            f14_local0 = element.super:gainFocus(event)
        end
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
        return f14_local0
    end)
    menu:AddButtonCallbackFunction(self.FooterButtonFriends, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility(element, menu, controller)
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
        return false
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonFriends, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility(element, menu, controller)
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
        return false
    end, false)
    self:addElement(self.FooterButtonFriends)

    self.FooterButtonSocial = CoD.FooterButton_Persistent.new(menu, controller, 0, 0, 240, 360, 0, 1, 0, 0)
    self.FooterButtonSocial:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                  return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.CanOpenSocialMenu(controller, menu)
            end
        }
    })
    self.FooterButtonSocial:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonSocial, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    self.FooterButtonSocial:subscribeToModel(Engine[@"hash_78DF2E5447F384B9"]()["lobbyRoot.lobbyNetworkMode"], function (ModelRef)
        menu:updateElementState(FooterButtonSocial, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "lobbyRoot.lobbyNetworkMode"
        })
    end, false)
    self.FooterButtonSocial:subscribeToModel(Engine[@"hash_78DF2E5447F384B9"]()["lobbyRoot.lobbyNav"], function (ModelRef)
        menu:updateElementState(self.FooterButtonSocial, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "lobbyRoot.lobbyNav"
        })
    end, false)
    self.FooterButtonSocial.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_18E8C0862204180A"))
    self.FooterButtonSocial.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_A4F37A001911A0A"))
    self.FooterButtonSocial.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5C4B68D4F7C51908"))
    self.FooterButtonSocial.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function ()
        self.FooterButtonSocial.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_3EB01F705FEE50EE")))
    end

    self.FooterButtonSocial.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
    self.FooterButtonSocial:subscribeToModel(Engine[@"hash_78DF2E5447F384B9"]()["lobbyRoot.lobbyNetworkMode"], function (f24_arg0, f24_arg1)
        CoD.Menu.UpdateButtonShownState(f24_arg1, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(f24_arg1, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
    end, false)
    self.FooterButtonSocial:subscribeToModel(Engine[@"hash_78DF2E5447F384B9"]()["lobbyRoot.lobbyNav"], function (f25_arg0, f25_arg1)
        CoD.Menu.UpdateButtonShownState(f25_arg1, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(f25_arg1, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
    end, false)
    self.FooterButtonSocial:registerEventHandler("gain_focus", function (element, event)
        local f26_local0 = nil
        if element.gainFocus then
            f26_local0 = element:gainFocus(event)
        elseif element.super.gainFocus then
            f26_local0 = element.super:gainFocus(event)
        end
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
        return f26_local0
    end)
    menu:AddButtonCallbackFunction(self.FooterButtonSocial, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        if not IsLAN()and not IsPlayerAGuest(controller)and IsPlayerAllowedToPlayOnline(controller)then
            CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_opensocial")
            return true
        else
              
        end
    end, function (element, menu, controller)
        if not IsLAN()and not IsPlayerAGuest(controller)and IsPlayerAllowedToPlayOnline(controller)then
            CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
            return false
        else
            return false
        end
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonSocial, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        if not IsLAN()and not IsPlayerAGuest(controller)and IsPlayerAllowedToPlayOnline(controller)then
            CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_opensocial")
            return true
        else
              
        end
    end, function (element, menu, controller)
        if not IsLAN()and not IsPlayerAGuest(controller)and IsPlayerAllowedToPlayOnline(controller)then
            CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
            return false
        else
            return false
        end
    end, false)
    self:addElement(self.FooterButtonSocial)

    self.FooterButtonStore = CoD.FooterButton_Persistent.new(menu, controller, 0, 0, 360, 480, 0, 1, 0, 0)
    self.FooterButtonStore:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                  return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.CanOpenStore(controller, menu)
            end
        }
    })
    self.FooterButtonStore:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonStore, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    self.FooterButtonStore:setAlpha(0)
    self.FooterButtonStore.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_111EC45AB3B0626"))
    self.FooterButtonStore.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4861ED6423EBD90E"))
    self.FooterButtonStore.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4191CDDA584B4408"))
    self.FooterButtonStore.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_48EF09D289B2D63E"))
    self.FooterButtonStore:registerEventHandler("gain_focus", function (element, event)
        local f33_local0 = nil
        if element.gainFocus then
            f33_local0 = element:gainFocus(event)
        elseif element.super.gainFocus then
            f33_local0 = element.super:gainFocus(event)
        end
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
        return f33_local0
    end)
    menu:AddButtonCallbackFunction(self.FooterButtonStore, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_openstore")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
        return false
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonStore, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_openstore")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
        return false
    end, false)
    self:addElement(self.FooterButtonStore)

    self.FooterButtonSettings = CoD.FooterButton_Persistent.new(menu, controller, 0, 0, 480, 600, 0, 1, 0, 0)
    self.FooterButtonSettings:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                  return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.CanOpenSettings(controller, menu)
            end
        }
    })
    self.FooterButtonSettings:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonSettings, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    self.FooterButtonSettings.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1FBCDFDF3FB70BDC"))
    self.FooterButtonSettings.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5110681AB84DEE00"))
    self.FooterButtonSettings.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_11762CBFBF851D22"))
    self.FooterButtonSettings.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function ()
        self.FooterButtonSettings.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_4AE4ED13AED2E15C")))
    end

    self.FooterButtonSettings.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
    self.FooterButtonSettings:registerEventHandler("gain_focus", function (element, event)
        local f41_local0 = nil
        if element.gainFocus then
            f41_local0 = element:gainFocus(event)
        elseif element.super.gainFocus then
            f41_local0 = element.super:gainFocus(event)
        end
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
        return f41_local0
    end)
    menu:AddButtonCallbackFunction(self.FooterButtonSettings, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_opensettings")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
        return false
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonSettings, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_opensettings")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
        return false
    end, false)
    self:addElement(self.FooterButtonSettings)

    self.FooterButtonCustomSettings = CoD.FooterButton_Persistent.new(menu, controller, 0, 0, 720, 960, 0, 1, 0, 0)
    self.FooterButtonCustomSettings:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                  return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.CanOpenPlayerAccount(controller, menu)
            end
        }
    })
    self.FooterButtonCustomSettings:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonCustomSettings, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonCustomSettings, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_openCustomSettings")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
        return false
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonCustomSettings, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_openCustomSettings")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
        return false
    end, false)
    self.FooterButtonCustomSettings.label:setText("Custom Settings")
    self.FooterButtonCustomSettings.label2:setText("Custom Settings")
    self.FooterButtonCustomSettings.footerTooltip.label:setText("")
    self:addElement(self.FooterButtonCustomSettings)

    self.FooterButtonPlayerAccount = CoD.FooterButton_Player.new(menu, controller, 0, 0, 600, 720, 0, 1, 0, 0)
    self.FooterButtonPlayerAccount:mergeStateConditions({
        {
            stateName = "Disabled",
            condition = function (menu, element, event)
                  return CoD.PCUtility.AreUIShortcutInputLocked(controller)and not CoD.PCUtility.CanOpenPlayerAccount(controller, menu)
            end
        }
    })
    self.FooterButtonPlayerAccount:subscribeToModel(Engine[@"hash_4DF5CFBC1771947"](controller).LockUIShortcutInput, function (ModelRef)
        menu:updateElementState(self.FooterButtonPlayerAccount, {
            name = "model_validation",
            menu = menu,
            controller = controller,
            modelValue = ModelRef:get(),
            modelName = "LockUIShortcutInput"
        })
    end, false)
    self.FooterButtonPlayerAccount.Internal.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_B828992E638B17B"))
    self.FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind.__Internal_TooltipKeybind = function ()
        self.FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_2689F7EF9B424B")))
    end

    self.FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind.__Internal_TooltipKeybind()
    self.FooterButtonPlayerAccount:registerEventHandler("gain_focus", function (element, event)
        local f49_local0 = nil
        if element.gainFocus then
              f49_local0 = element:gainFocus(event)
        elseif element.super.gainFocus then
              f49_local0 = element.super:gainFocus(event)
        end
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"])
        CoD.Menu.UpdateButtonShownState(element, menu, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"])
        return f49_local0
    end)
    menu:AddButtonCallbackFunction(self.FooterButtonPlayerAccount, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_openPlayerAccount")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm")
        return false
    end, false)
    menu:AddButtonCallbackFunction(self.FooterButtonPlayerAccount, controller, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], "MOUSE1", function (element, menu, controller, model)
        CoD.PCUtility.ToggleShortcutMenu(menu, controller, "ui_openPlayerAccount")
        return true
    end, function (element, menu, controller)
        CoD.Menu.SetButtonLabel(menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3865DD2DB1EFE9F8"], @"hash_0", nil, "MOUSE1")
        return false
    end, false)
    self:addElement(self.FooterButtonPlayerAccount)

    self.FooterButtonChat:subscribeToModel(DataSources.KeybindMessages.getModel(controller).isBindingKey, self.FooterButtonChat.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
    self.FooterButtonFriends:subscribeToModel(DataSources.KeybindMessages.getModel(controller).isBindingKey, self.FooterButtonFriends.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
    self.FooterButtonSocial:subscribeToModel(DataSources.KeybindMessages.getModel(controller).isBindingKey, self.FooterButtonSocial.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
    self.FooterButtonSettings:subscribeToModel(DataSources.KeybindMessages.getModel(controller).isBindingKey, self.FooterButtonSettings.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
    self.FooterButtonPlayerAccount:subscribeToModel(DataSources.KeybindMessages.getModel(controller).isBindingKey, self.FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind.__Internal_TooltipKeybind)
    if CoD.isPC then
        self.FooterButtonChat.id = "FooterButtonChat"
        self.FooterButtonFriends.id = "FooterButtonFriends"
        self.FooterButtonSocial.id = "FooterButtonSocial"
        self.FooterButtonStore.id = "FooterButtonStore"
        self.FooterButtonSettings.id = "FooterButtonSettings"
        self.FooterButtonPlayerAccount.id = "FooterButtonPlayerAccount"
        self.FooterButtonCustomSettings.id = "FooterButtonCustomSettings"
    end
    LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
    if PostLoadFunc then
        PostLoadFunc(self, controller, menu)
    end
    SetElementProperty(self.FooterButtonChat, "__isChatToggleButton", true)
    SetElementProperty(self.FooterButtonFriends, "__isFrontendBattlenetToggleButton", true)
    if IsInGame()then
        HideWidget(self.FooterButtonPlayerAccount)
        self.FooterButtonCustomSettings:setLeftRight(false, false, 600, 840)
    end
    return self
end

CoD.FooterButton_PersistentLeftContainer.__onClose = function (element)
    element.FooterButtonChat:close()
    element.FooterButtonFriends:close()
    element.FooterButtonSocial:close()
    element.FooterButtonStore:close()
    element.FooterButtonSettings:close()
    element.FooterButtonPlayerAccount:close()
    element.FooterButtonCustomSettings:close()
end