local Interface = {
    -- styles 
    theme = {
        palette = {
            background = {0.1, 0.1, 0.1, 0.9},
            text = {1.0, 1.0, 1.0, 1.0},
            button = {0.2, 0.2, 0.2, 1.0},
            buttonHover = {0.3, 0.3, 0.3, 1.0},
            buttonActive = {0.4, 0.4, 0.4, 1.0}
        },
        windowProperties = ImGuiWindowFlags.NoTitleBar + 
                         ImGuiWindowFlags.AlwaysAutoResize + 
                         ImGuiWindowFlags.NoFocusOnAppearing
    },
    
    -- init
    initialize = function(self, mod)
        self.mod = mod
        self:applyTheme()
    end,
    
    -- theme
    applyTheme = function(self)
        ImGui.PushStyleColor(ImGuiCol.WindowBg, 
            self.theme.palette.background[1],
            self.theme.palette.background[2],
            self.theme.palette.background[3],
            self.theme.palette.background[4])
    end,
    
    -- main win
    render = function(self)
        if not self.mod.runtime.isInterfaceVisible then return end
        
        ImGui.SetNextWindowPos(50, 50, ImGuiCond.FirstUseEver)
        
        if ImGui.Begin('CyberCollector Control Panel', true, self.theme.windowProperties) then
            self:renderSettings()
            self:renderStatus()
            ImGui.End()
        end
    end,
    
    -- settings
    renderSettings = function(self)
        ImGui.TextColored(1.0, 1.0, 1.0, 1.0, 'CyberCollector Settings')
        ImGui.Separator()
        
        
        local radius = self.mod.config.scanRadius
        if ImGui.SliderInt('Scan Radius', radius, 100, 2000) then
            self.mod.config.scanRadius = radius
        end
        
        
        local autoHarvest = self.mod.config.autoHarvest
        if ImGui.Checkbox('Auto Harvest', autoHarvest) then
            self.mod.config.autoHarvest = autoHarvest
        end
        
        
        local smartSorting = self.mod.config.smartSorting
        if ImGui.Checkbox('Smart Sorting', smartSorting) then
            self.mod.config.smartSorting = smartSorting
        end
        
        
        local developerMode = self.mod.config.developerMode
        if ImGui.Checkbox('Developer Mode', developerMode) then
            self.mod.config.developerMode = developerMode
        end
    end,
    
    -- main status
    renderStatus = function(self)
        ImGui.Separator()
        local status = self.mod.runtime.isHarvesting and 'Harvesting...' or 'Standby'
        ImGui.TextColored(1.0, 1.0, 1.0, 1.0, 'Status: ' .. status)
    end
}

return Interface 
