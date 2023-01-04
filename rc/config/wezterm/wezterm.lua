local wezterm = require 'wezterm'

return {
  color_scheme = 'Dracula (Official)',
  font = wezterm.font 'Hasklig',
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_decorations = 'RESIZE',
  leader = { key = ';', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      key = 's',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'c',
      mods = 'LEADER',
      action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = 'q',
      mods = 'LEADER',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = 'h',
      mods = 'OPT',
      action = wezterm.action.ActivateTabRelative(-1),
    },
    {
      key = 'l',
      mods = 'OPT',
      action = wezterm.action.ActivateTabRelative(1),
    },
    {
      key = 'h',
      mods = 'CTRL|OPT',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'CTRL|OPT',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'CTRL|OPT',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'CTRL|OPT',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
  },
}
