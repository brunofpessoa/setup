local wezterm = require("wezterm")
local config = wezterm.config_builder()
local action = wezterm.action

-- config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("JetBrainsMono NF")
config.font_size = 12
config.window_decorations = "RESIZE"
config.color_scheme = "Ayu Mirage"
config.window_background_opacity = 1

config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {}

local function map(mods, key, act)
    table.insert(config.keys, { mods = mods, key = key, action = act })
end

-- Panes
map("LEADER", "x", action.CloseCurrentPane({ confirm = true }))
map("CTRL|SHIFT", "n", action.SpawnTab("CurrentPaneDomain"))
map("LEADER", "p", action.ActivateTabRelative(-1))
map("LEADER", "n", action.ActivateTabRelative(1))
map("LEADER", "h", action.SplitHorizontal({ domain = 'CurrentPaneDomain' }))
map("LEADER", "v", action.SplitVertical({ domain = "CurrentPaneDomain" }))
-- Pane Navigation
map("CTRL|SHIFT", "j", action.ActivatePaneDirection("Down"))
map("CTRL|SHIFT", "k", action.ActivatePaneDirection("Up"))
map("CTRL|SHIFT", "h", action.ActivatePaneDirection("Left"))
map("CTRL|SHIFT", "l", action.ActivatePaneDirection("Right"))
-- Resize panes
map("CTRL|SHIFT", "LeftArrow", action.AdjustPaneSize({ "Left", 2 }))
map("CTRL|SHIFT", "RightArrow", action.AdjustPaneSize({ "Right", 2 }))
map("CTRL|SHIFT", "UpArrow", action.AdjustPaneSize({ "Up", 2 }))
map("CTRL|SHIFT", "DownArrow", action.AdjustPaneSize({ "Down", 2 }))
-- Tab Navigation
for i = 1, 9 do
    map("LEADER", tostring(i), action.ActivateTab(i - 1))
end

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.tab_and_split_indices_are_zero_based = false

return config
