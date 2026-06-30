-- ==================================
-- SERVICES MODULE
-- ==================================
-- Menyimpan semua game:GetService() di satu tempat

local Services = {}

-- Daftar Services
local services = {
	"Players",
	"Workspace",
	"RunService",
	"UserInputService",
	"ProximityPromptService",
	"TweenService",
	"Debris",
}

function Services:Initialize()
	for _, serviceName in ipairs(services) do
		self[serviceName] = game:GetService(serviceName)
		print("[Services] Loaded: " .. serviceName)
	end
end

function Services:Get(serviceName)
	return self[serviceName] or game:GetService(serviceName)
end

return Services