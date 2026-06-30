-- ==================================
-- UI MODULE
-- ==================================
-- Mengelola semua GUI, Tab, Button, Toggle, dll

local UI = {
	Windows = {},
	Tabs = {},
	Buttons = {},
}

function UI:Initialize()
	print("[UI] Loaded")
end

function UI:CreateWindow(name)
	local window = {
		Name = name,
		Tabs = {},
	}
	self.Windows[name] = window
	print("[UI] Created window: " .. name)
	return window
end

function UI:CreateTab(windowName, tabName)
	if self.Windows[windowName] then
		local tab = {
			Name = tabName,
			Elements = {},
		}
		table.insert(self.Windows[windowName].Tabs, tab)
		print("[UI] Created tab: " .. tabName)
		return tab
	end
end

return UI