-- ==================================
-- HUB LOADER - MAIN ENTRY POINT
-- ==================================
-- Script ini di-execute pertama kali untuk load seluruh hub

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ==================================
-- CONFIGURATION
-- ==================================

local HUB_CONFIG = {
	Owner = "Anugrah0",
	Repo = "Tikus",
	Branch = "main",
	BasePath = "GameFramework",
	RawURL = "https://raw.githubusercontent.com/%s/%s/%s/%s",
}

-- ==================================
-- UTILITY FUNCTIONS
-- ==================================

local function GetRawURL(filePath)
	return string.format(HUB_CONFIG.RawURL, HUB_CONFIG.Owner, HUB_CONFIG.Repo, HUB_CONFIG.Branch, filePath)
end

local function Log(message, logType)
	logType = logType or "INFO"
	local prefix = string.format("[%s HUB] [%s]", HUB_CONFIG.Owner, logType)
	print(prefix .. " " .. message)
end

-- ==================================
-- CORE LOADER ENGINE
-- ==================================

local Loader = {}

function Loader:LoadModule(modulePath)
	Log("Loading module: " .. modulePath, "LOAD")
	
	local url = GetRawURL(modulePath)
	
	local success, result = pcall(function()
		return HttpService:GetAsync(url)
	end)
	
	if success then
		Log("✅ Module loaded: " .. modulePath, "SUCCESS")
		local moduleFunc = loadstring(result, modulePath)
		return moduleFunc()
	else
		Log("❌ Failed to load " .. modulePath .. " | " .. result, "ERROR")
		return nil
	end
end

function Loader:LoadAllModules()
	Log("Initializing Hub Loader...", "INFO")
	
	local modules = {
		Services = HUB_CONFIG.BasePath .. "/Services/Services.lua",
		Variables = HUB_CONFIG.BasePath .. "/Variables/Variables.lua",
		Settings = HUB_CONFIG.BasePath .. "/Settings/Settings.lua",
		Cache = HUB_CONFIG.BasePath .. "/Cache/Cache.lua",
		Functions = HUB_CONFIG.BasePath .. "/Functions/Functions.lua",
		Connections = HUB_CONFIG.BasePath .. "/Connections/Connections.lua",
		UI = HUB_CONFIG.BasePath .. "/UI/UI.lua",
	}
	
	local loadedModules = {}
	
	for name, path in pairs(modules) do
		loadedModules[name] = self:LoadModule(path)
	end
	
	return loadedModules
end

function Loader:LoadFeatures()
	Log("Loading features...", "INFO")
	
	local features = {
		InstantPrompt = HUB_CONFIG.BasePath .. "/Features/InstantPrompt.lua",
		AutoCollect = HUB_CONFIG.BasePath .. "/Features/AutoCollect.lua",
	}
	
	local loadedFeatures = {}
	
	for name, path in pairs(features) do
		loadedFeatures[name] = self:LoadModule(path)
	end
	
	return loadedFeatures
end

-- ==================================
-- MAIN HUB
-- ==================================

local Hub = {
	Name = "Game Hub",
	Version = "1.0.0",
	Owner = HUB_CONFIG.Owner,
	Modules = {},
	Features = {},
	Config = HUB_CONFIG,
}

function Hub:Initialize()
	Log("=" .. string.rep("=", 40), "INFO")
	Log("Initializing " .. self.Name .. " v" .. self.Version, "INFO")
	Log("=" .. string.rep("=", 40), "INFO")
	
	-- Load Core Modules
	self.Modules = Loader:LoadAllModules()
	
	-- Initialize Modules
	if self.Modules.Services then
		self.Modules.Services:Initialize()
	end
	
	if self.Modules.Variables then
		self.Modules.Variables:Initialize()
	end
	
	if self.Modules.Settings then
		self.Modules.Settings:Initialize()
	end
	
	if self.Modules.Cache then
		self.Modules.Cache:Initialize()
	end
	
	if self.Modules.Functions then
		self.Modules.Functions:Initialize()
	end
	
	if self.Modules.Connections then
		self.Modules.Connections:Initialize()
	end
	
	if self.Modules.UI then
		self.Modules.UI:Initialize()
	end
	
	-- Load Features
	self.Features = Loader:LoadFeatures()
	
	-- Initialize Features
	for name, feature in pairs(self.Features) do
		if feature and feature.Initialize then
			feature:Initialize()
		end
	end
	
	Log("=" .. string.rep("=", 40), "SUCCESS")
	Log("Hub loaded successfully! Welcome " .. LocalPlayer.Name, "SUCCESS")
	Log("=" .. string.rep("=", 40), "SUCCESS")
end

function Hub:EnableFeature(featureName)
	if self.Features[featureName] then
		self.Features[featureName]:Enable()
		Log(featureName .. " enabled", "SUCCESS")
	else
		Log(featureName .. " not found", "ERROR")
	end
end

function Hub:DisableFeature(featureName)
	if self.Features[featureName] then
		self.Features[featureName]:Disable()
		Log(featureName .. " disabled", "SUCCESS")
	else
		Log(featureName .. " not found", "ERROR")
	end
end

function Hub:Shutdown()
	Log("Shutting down hub...", "INFO")
	
	-- Disable all features
	for name, feature in pairs(self.Features) do
		if feature and feature.Disable then
			feature:Disable()
		end
	end
	
	-- Clear connections
	if self.Modules.Connections then
		self.Modules.Connections:RemoveAll()
	end
	
	-- Clear cache
	if self.Modules.Cache then
		self.Modules.Cache:Clear()
	end
	
	Log("Hub shutdown complete", "SUCCESS")
end

-- ==================================
-- COMMAND INTERFACE
-- ==================================

function Hub:GetCommand(name)
	return self.Commands and self.Commands[name]
end

function Hub:ExecuteCommand(commandName, ...)
	local cmd = self:GetCommand(commandName)
	if cmd then
		cmd(...)
	else
		Log("Command not found: " .. commandName, "ERROR")
	end
end

-- ==================================
-- INITIALIZE HUB
-- ==================================

Hub:Initialize()

-- ==================================
-- EXPORT HUB FOR GLOBAL ACCESS
-- ==================================

_G.GameHub = Hub

-- ==================================
-- QUICK ACCESS EXAMPLES
-- ==================================

print("\n" .. string.rep("=", 50))
print("QUICK ACCESS GUIDE:")
print("=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=")
print("Access Hub: _G.GameHub")
print("Enable Feature: _G.GameHub:EnableFeature('InstantPrompt')")
print("Disable Feature: _G.GameHub:DisableFeature('InstantPrompt')")
print("=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=".."=")
print("")

return Hub
