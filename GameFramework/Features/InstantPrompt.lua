-- ==================================
-- FEATURE: INSTANT PROMPT
-- ==================================
-- Menghilangkan HoldDuration pada ProximityPrompt

local InstantPrompt = {
	Enabled = false,
	Prompts = {},
	Connections = {},
}

local Services
local Settings
local Connections
local Functions

function InstantPrompt:Initialize()
	Services = require(script.Parent.Parent.Services.Services)
	Settings = require(script.Parent.Parent.Settings.Settings)
	Connections = require(script.Parent.Parent.Connections.Connections)
	Functions = require(script.Parent.Parent.Functions.Functions)
	
	print("[InstantPrompt] Initialized")
end

function InstantPrompt:Enable()
	if self.Enabled then return end
	self.Enabled = true
	
	local ProximityPromptService = Services:Get("ProximityPromptService")
	local Workspace = Services:Get("Workspace")
	
	-- Hook untuk prompt yang ditampilkan
	local onPromptShown = ProximityPromptService.PromptShown:Connect(function(prompt)
		if not self.Prompts[prompt] then
			self.Prompts[prompt] = prompt.HoldDuration
			prompt.HoldDuration = 0
		end
	end)
	
	-- Hook untuk prompt yang disembunyikan
	local onPromptHidden = ProximityPromptService.PromptHidden:Connect(function(prompt)
		if self.Prompts[prompt] then
			prompt.HoldDuration = self.Prompts[prompt]
			self.Prompts[prompt] = nil
		end
	end)
	
	-- Proses prompt yang sudah ada
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("ProximityPrompt") and not self.Prompts[obj] then
			self.Prompts[obj] = obj.HoldDuration
			obj.HoldDuration = 0
		end
	end
	
	Connections:Add("InstantPrompt_PromptShown", onPromptShown)
	Connections:Add("InstantPrompt_PromptHidden", onPromptHidden)
	
	print("[InstantPrompt] Enabled")
end

function InstantPrompt:Disable()
	if not self.Enabled then return end
	self.Enabled = false
	
	Connections:Remove("InstantPrompt_PromptShown")
	Connections:Remove("InstantPrompt_PromptHidden")
	
	-- Restore semua prompt ke HoldDuration asli
	for prompt, hold in pairs(self.Prompts) do
		if prompt and prompt.Parent then
			prompt.HoldDuration = hold
		end
	end
	
	table.clear(self.Prompts)
	print("[InstantPrompt] Disabled")
end

return InstantPrompt