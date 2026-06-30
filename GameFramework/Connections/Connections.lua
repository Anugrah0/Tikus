-- ==================================
-- CONNECTIONS MODULE
-- ==================================
-- Mengelola semua RBXScriptConnection untuk mencegah memory leak

local Connections = {
	Active = {},
}

function Connections:Initialize()
	print("[Connections] Manager loaded")
end

function Connections:Add(name, connection)
	self.Active[name] = connection
	print("[Connections] Added: " .. name)
end

function Connections:Remove(name)
	if self.Active[name] then
		self.Active[name]:Disconnect()
		self.Active[name] = nil
		print("[Connections] Removed: " .. name)
	end
end

function Connections:RemoveAll()
	for name, connection in pairs(self.Active) do
		if connection then
			connection:Disconnect()
		end
	end
	table.clear(self.Active)
	print("[Connections] All connections cleared")
end

return Connections