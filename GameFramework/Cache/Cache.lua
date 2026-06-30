-- ==================================
-- CACHE MODULE
-- ==================================
-- Menyimpan data sementara untuk menghindari pencarian berulang

local Cache = {
	Prompts = {},
	Zones = {},
	Plates = {},
	Data = {},
}

function Cache:Initialize()
	print("[Cache] Initialized")
end

function Cache:Set(key, value)
	self.Data[key] = value
end

function Cache:Get(key)
	return self.Data[key]
end

function Cache:Clear()
	table.clear(self.Data)
	table.clear(self.Prompts)
	table.clear(self.Zones)
	table.clear(self.Plates)
	print("[Cache] Cleared")
end

return Cache