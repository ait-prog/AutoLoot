local CyberCollector = {
	version = 'v1.0.0',
	name = 'CyberCollector',
	author = 'ait-prog',
	
	-- main settings
	config = {
		scanRadius = 1000,
		autoHarvest = true,
		smartSorting = true,
		displayInterface = false,
		developerMode = false
	},
	
	
	runtime = {
		isHarvesting = false,
		lastHarvestTime = 0,
		harvestCooldown = 0.3,
		isInterfaceVisible = false
	},
	
	-- init
	initialize = function(self)
		self:loadUserPreferences()
		self:setupInterface()
		self:bindEvents()
		print(self.name .. ' ' .. self.version .. ' initialized')
	end,
	
	-- downloads
	loadUserPreferences = function(self)
		local preferences = require('preferences')
		if preferences then
			for k, v in pairs(preferences) do
				self.config[k] = v
			end
		end
	end,
	
	-- ui settings
	setupInterface = function(self)
		self.interface = require('interface')
		if self.interface then
			self.interface.initialize(self)
		end
	end,
	
	--  ecent register
	bindEvents = function(self)
		registerForEvent('onInit', function()
			self:initialize()
		end)
		
		registerForEvent('onUpdate', function(delta)
			self:processUpdate(delta)
		end)
		
		registerForEvent('onDraw', function()
			self:renderInterface()
		end)
		
		registerForEvent('onOverlayOpen', function()
			self.runtime.isInterfaceVisible = true
		end)
		
		registerForEvent('onOverlayClose', function()
			self.runtime.isInterfaceVisible = false
		end)
	end,
	
	-- update
	processUpdate = function(self, delta)
		if self.runtime.isHarvesting then
			local currentTime = os.clock()
			if currentTime - self.runtime.lastHarvestTime >= self.runtime.harvestCooldown then
				self:executeHarvest()
				self.runtime.lastHarvestTime = currentTime
			end
		end
	end,
	

	executeHarvest = function(self)
		local player = Game.GetPlayer()
		if not player then return end
		
		local targets = self:scanForTargets()
		for _, target in ipairs(targets) do
			if self:validateTarget(target) then
				self:collectTarget(target)
			end
		end
	end,
	

	scanForTargets = function(self)
		local targets = {}
		-- need item's id
		return targets
	end,
	

	validateTarget = function(self, target)
		if not self.config.smartSorting then return true end
		-- need logic
		return true
	end,
	

	collectTarget = function(self, target)
		-- need logic
	end,
	

	renderInterface = function(self)
		if self.runtime.isInterfaceVisible then
			self.interface.render(self)
		end
	end
}


registerInput('CyberCollector', 'CyberCollector', function(isKeyDown)
	CyberCollector.runtime.isHarvesting = isKeyDown
end)

return CyberCollector
