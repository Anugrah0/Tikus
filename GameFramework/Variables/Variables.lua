-- ==================================
-- VARIABLES MODULE
-- ==================================
-- Menyimpan variabel global dan state

local Variables = {}
local Services = require(script.Parent.Parent.Services.Services)

function Variables:Initialize()
	-- Get Services
	self.Players = Services:Get("Players")
	self.Workspace = Services:Get("Workspace")
	
	-- Get Player Info
	self.LocalPlayer = self.Players.LocalPlayer
	self.Character = self.LocalPlayer.Character or self.LocalPlayer.CharacterAdded:Wait()
	self.Humanoid = self.Character:WaitForChild("Humanoid")
	self.HumanoidRootPart = self.Character:WaitForChild("HumanoidRootPart")
	self.UserId = self.LocalPlayer.UserId
	
	-- Game Specific
	self.Runtime = self.Workspace:WaitForChild("Runtime")
	self.MyZone = nil
	
	print("[Variables] Initialized successfully")
end

return Variables