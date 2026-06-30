# Game Framework

Struktur framework modular untuk game scripting di Roblox.

## 📁 Struktur Folder

```
GameFramework/
├── Main.lua              # Entry point utama
├── Services/             # Semua game:GetService() di sini
├── Variables/            # Variabel global dan state
├── Settings/             # Konfigurasi (Toggle, Delay, Keybind, dll)
├── Cache/                # Penyimpanan data sementara
├── Functions/            # Utility functions untuk semua modul
├── Connections/          # Manager untuk RBXScriptConnection
├── UI/                   # GUI, Tab, Button, Toggle, Slider, dll
└── Features/             # Fitur-fitur game
    ├── InstantPrompt.lua # Instant proximity prompts
    └── AutoCollect.lua   # Auto collect items
```

## 🎯 Prinsip Desain

1. **Modular & Independent**: Setiap fitur berdiri sendiri dan tidak bergantung satu sama lain
2. **Reusable**: Semua fungsi umum disimpan di `Functions` module
3. **Memory Safe**: Connection manager mencegah memory leak
4. **Scalable**: Mudah menambah fitur baru tanpa mengubah struktur yang ada
5. **Debuggable**: Semua module memiliki logging dan struktur yang jelas

## 🚀 Cara Menggunakan

### 1. Meload Framework

```lua
local Framework = require(script.GameFramework.Main)
```

### 2. Mengaktifkan Fitur

```lua
-- Instant Prompt
Framework.Features.InstantPrompt:Enable()
Framework.Features.InstantPrompt:Disable()

-- Auto Collect
Framework.Features.AutoCollect:Enable()
Framework.Features.AutoCollect:Disable()
```

### 3. Menambah Fitur Baru

Buat file baru di folder `Features` dengan struktur:

```lua
local NewFeature = {
    Enabled = false,
    Connections = {},
}

function NewFeature:Initialize()
    -- Load dependencies
    print("[NewFeature] Initialized")
end

function NewFeature:Enable()
    if self.Enabled then return end
    self.Enabled = true
    -- Implementasi fitur
end

function NewFeature:Disable()
    if not self.Enabled then return end
    self.Enabled = false
    -- Cleanup
end

return NewFeature
```

## 📝 Module Documentation

### Services
Menyimpan semua `game:GetService()` untuk akses global.

### Variables
Menyimpan state game seperti `LocalPlayer`, `Character`, `HumanoidRootPart`, dll.

### Settings
Konfigurasi untuk setiap fitur (Toggle, Delay, Keybind, Default Value).

### Cache
Data sementara untuk menghindari pencarian berulang (Prompts, Zones, Plates, dll).

### Functions
Utility functions yang dapat digunakan semua modul:
- `Teleport(position)` - Teleport ke posisi
- `GetMyZone()` - Cari zona milik player
- `Notify(message)` - Menampilkan notifikasi
- `TweenTo(targetCFrame, duration)` - Tween movement

### Connections
Manager untuk mengatur RBXScriptConnection:
- `Add(name, connection)` - Tambah connection
- `Remove(name)` - Hapus connection
- `RemoveAll()` - Hapus semua connection

### UI
Template untuk membuat GUI (work in progress).

### Features
Setiap fitur memiliki structure:
- `Initialize()` - Setup modul
- `Enable()` - Aktifkan fitur
- `Disable()` - Matikan fitur

## ✅ TODO

- [ ] Lengkapi UI module dengan button, toggle, slider
- [ ] Tambah AutoTP feature
- [ ] Tambah ESP feature
- [ ] Tambah Tween animation system
- [ ] Tambah keybind system
- [ ] Tambah notification system

---

**Version**: 1.0  
**Author**: Game Framework Team