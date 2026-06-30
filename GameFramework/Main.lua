-- ==================================
-- GAME FRAMEWORK - MAIN
-- ==================================

-- Load Framework Modules
local Services = require(script.Services.Services)
local Variables = require(script.Variables.Variables)
local Settings = require(script.Settings.Settings)
local Cache = require(script.Cache.Cache)
local Functions = require(script.Functions.Functions)
local Connections = require(script.Connections.Connections)
local UI = require(script.UI.UI)

-- Load Features
local InstantPrompt = require(script.Features.InstantPrompt)
local AutoCollect = require(script.Features.AutoCollect)

-- ==================================
-- INITIALIZE FRAMEWORK
-- ==================================

local Framework = {
	Name = "GameFramework",
	Version = "1.0",
	Modules = {
		Services = Services,
		Variables = Variables,
		Settings = Settings,
		Cache = Cache,
		Functions = Functions,
		Connections = Connections,
		UI = UI,
	},
	Features = {
		InstantPrompt = InstantPrompt,
		AutoCollect = AutoCollect,
	}
}

-- Inisialisasi Services
print("[Framework] Loading Services...")
Services:Initialize()

-- Inisialisasi Variables
print("[Framework] Loading Variables...")
Variables:Initialize()

-- Inisialisasi Settings
print("[Framework] Loading Settings...")
Settings:Initialize()

-- Inisialisasi Cache
print("[Framework] Loading Cache...")
Cache:Initialize()

-- Inisialisasi Functions
print("[Framework] Loading Functions...")
Functions:Initialize()

-- Inisialisasi Connections Manager
print("[Framework] Loading Connections Manager...")
Connections:Initialize()

-- Inisialisasi UI
print("[Framework] Loading UI...")
UI:Initialize()

-- Inisialisasi Features
print("[Framework] Loading Features...")
InstantPrompt:Initialize()
AutoCollect:Initialize()

print("[Framework] Framework loaded successfully!")

return Framework