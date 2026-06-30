-- ==================================
-- FUNCTIONS MODULE
-- ==================================
-- Fungsi utility yang digunakan oleh semua modul

local Functions = {}
local Services = require(script.Parent.Parent.Services.Services)
local Variables = require(script.Parent.Parent.Variables.Variables)

function Functions:Initialize()
	print("[Functions] Loaded")
end

-- Teleport ke posisi
function Functions:Teleport(position)
	if Variables.HumanoidRootPart then
		Variables.HumanoidRootPart.CFrame = CFrame.new(position)
	end
end

-- Cari zona milik player
function Functions:GetMyZone()
	local Runtime = Variables.Runtime
	local UserId = Variables.UserId
	
	for _, zone in ipairs(Runtime:GetChildren()) do
		if zone.Name:match("^ZonePedestals_") then
			local ownerId = zone:GetAttribute("OwnerId")
			if ownerId == UserId then
				return zone
			end
			
			if not ownerId then
				for _, obj in ipairs(zone:GetDescendants()) do
					if obj:GetAttribute("OwnerId") == UserId then
						return zone
					end
				end
			end
	end
	return nil
end

-- Notify (placeholder)
function Functions:Notify(message)
	if Variables.Modules.Settings.Debug then
		print("[Notification] " .. message)
	end
end

-- Tween ke posisi
function Functions:TweenTo(targetCFrame, duration)
	local TweenService = Services:Get("TweenService")
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(Variables.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
	tween:Play()
	return tween
end

return Functions