-- ==================================
-- FEATURE: AUTO COLLECT
-- ==================================
-- Otomatis mengumpulkan item dari plate

local AutoCollect = {
	Enabled = false,
	Connections = {},
}

local Services
local Variables
local Settings
local Connections
local Functions

function AutoCollect:Initialize()
	Services = require(script.Parent.Parent.Services.Services)
	Variables = require(script.Parent.Parent.Variables.Variables)
	Settings = require(script.Parent.Parent.Settings.Settings)
	Connections = require(script.Parent.Parent.Connections.Connections)
	Functions = require(script.Parent.Parent.Functions.Functions)
	
	print("[AutoCollect] Initialized")
end

function AutoCollect:GetMyZone()
	return Functions:GetMyZone()
end

function AutoCollect:Enable()
	if self.Enabled then return end
	self.Enabled = true
	
	local myZone = self:GetMyZone()
	
	if not myZone then
		local attempts = 0
		repeat
			myZone = self:GetMyZone()
			if not myZone then
				task.wait(1)
				attempts = attempts + 1
				if attempts > 10 then
					local Runtime = Variables.Runtime
					for _, zone in ipairs(Runtime:GetChildren()) do
						if zone.Name:match("^ZonePedestals_") then
							myZone = zone
							break
						end
					end
					break
				end
			end
		until myZone
	end
	
	if not myZone then
		print("[AutoCollect] Zone not found!")
		return
	end
	
	-- Mulai collect
	self:CollectPlates(myZone)
end

function AutoCollect:CollectPlates(zone)
	local delay_val = Settings:Get("AutoCollect", "Delay") or 0.5
	local placeRange = Settings:Get("AutoCollect", "PlateRange") or 15
	local HumanoidRootPart = Variables.HumanoidRootPart
	
	for i = 1, placeRange do
		for _, side in ipairs({"R", "L"}) do
			local plate = zone:FindFirstChild("CollectPlate_" .. i .. side)
			
			if plate and plate:FindFirstChild("Part1") then
				HumanoidRootPart.CFrame = plate.Part1.CFrame + Vector3.new(0, 3, 0)
				task.wait(delay_val)
			end
		end
	end
	
	print("[AutoCollect] Collect finished")
	self.Enabled = false
end

function AutoCollect:Disable()
	if not self.Enabled then return end
	self.Enabled = false
	print("[AutoCollect] Disabled")
end

return AutoCollect