-- ==================================
-- SETTINGS MODULE
-- ==================================
-- Menyimpan semua konfigurasi

local Settings = {
	-- Instant Prompt Settings
	InstantPrompt = {
		Enabled = false,
		Keybind = Enum.KeyCode.P,
	},
	
	-- Auto Collect Settings
	AutoCollect = {
		Enabled = false,
		Keybind = Enum.KeyCode.C,
		Delay = 0.5,
		PlateRange = 15,
	},
	
	-- General Settings
	Debug = true,
}

function Settings:Initialize()
	print("[Settings] Loaded configuration")
end

function Settings:Get(featureName, settingName)
	if self[featureName] then
		return self[featureName][settingName]
	end
	return nil
end

function Settings:Set(featureName, settingName, value)
	if self[featureName] then
		self[featureName][settingName] = value
	end
end

return Settings