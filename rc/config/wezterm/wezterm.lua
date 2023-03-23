local wezterm = require 'wezterm'

local keys = {
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
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
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
  { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(1) },
  { key = 'UpArrow', mods = 'SHIFT|OPT', action = wezterm.action.ScrollByLine(-10) },
  { key = 'DownArrow', mods = 'SHIFT|OPT', action = wezterm.action.ScrollByLine(10) },
}

local navigation = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

function navigate(key, direction)
  return function (window, pane)
    local proc_info = pane:get_foreground_process_info()
    wezterm.log_info(proc_info)
    if proc_info.name == "nvim" then
      window:perform_action(wezterm.action.SendKey({ key = key, mods = 'CTRL' }), pane)
    else
      window:perform_action(wezterm.action.ActivatePaneDirection(direction), pane)
    end
  end
end

for key, direction in pairs(navigation) do
  local event_id = 'navigate-' .. direction
  wezterm.on(event_id,  navigate(key, direction))
  table.insert(keys, {
    key = key,
    mods = 'CTRL',
    action = wezterm.action.EmitEvent(event_id),
  })
end

return {
  color_scheme = 'Dracula (Official)',
  font = wezterm.font 'Hasklig',
  font_size = 18.5,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_decorations = 'RESIZE',
  leader = { key = ';', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = keys,
}
