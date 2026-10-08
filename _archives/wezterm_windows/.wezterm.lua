local wezterm = require("wezterm")
local act = wezterm.action

local shell_path = "/bin/zsh"

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

config.default_domain = "WSL:Arch"
config.send_composed_key_when_left_alt_is_pressed = false

-- Settings
config.default_prog = { shell_path, "-l" }

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 1000
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"

config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  { family = "CaskaydiaMono Nerd Font Mono", scale = 1.0 },
  { family = "CommitMono Nerd Font",         scale = 1.1 },
  { family = "CaskaydiaCove Nerd Font Mono", scale = 1.1, },
})
config.window_background_opacity = 0.95
config.macos_window_background_blur = 50
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

-- Dim inactive panes
-- config.inactive_pane_hsb = {
--   saturation = 0.24,
--   brightness = 0.5
-- }

-- Keys
config.leader = { key = "q", mods = "CTRL|ALT", timeout_milliseconds = 3000 }
config.keys = {
  { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },
-- { key = ',', mods = 'ALT|SHIFT', action = wezterm.action.DisableDefaultAssignment },

  { key = "c",  mods = "LEADER",      action = act.ActivateCopyMode },

  -- Pane keybindings
  { key = "s",  mods = "ALT|SHIFT",  action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "v",  mods = "ALT|SHIFT",  action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h",  mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "j",  mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "k",  mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "l",  mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "q",  mods = "ALT|SHIFT",  action = act.CloseCurrentPane { confirm = true } },
  -- { key = "z",  mods = "ALT|SHIFT",  action = act.TogglePaneZoomState },
  -- { key = "g",  mods = "ALT|SHIFT",  action = act.RotatePanes "Clockwise" },
  -- { key = "r",  mods = "ALT|SHIFT",  action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- Tab keybindings
  { key = "t",  mods = "ALT|SHIFT",  action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w",  mods = "ALT|SHIFT",  action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = ",",  mods = "ALT|SHIFT",  action = act.ActivateTabRelative(-1) },
  { key = ".",  mods = "ALT|SHIFT",  action = act.ActivateTabRelative(1) },
  -- { key = "e",  mods = "ALT|SHIFT",  action = act.ShowTabNavigator },
  {
    key = "r",
    mods = "ALT|SHIFT",
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Renaming Tab Title...:" },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end)
    }
  },
  -- { key = "m", mods = "ALT|SHIFT",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  { key = "p", mods = "ALT|SHIFT", action = act.MoveTabRelative(-1) },
  { key = "n", mods = "ALT|SHIFT", action = act.MoveTabRelative(1) },

  -- Lastly, workspace
  { key = "`", mods = "ALT|SHIFT",           action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom 'Clipboard' },
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo  'Clipboard' },
  { key = "=", mods = "CTRL|SHIFT",      action = act.IncreaseFontSize },
  { key = "-", mods = "CTRL|SHIFT",      action = act.DecreaseFontSize },
  { key = "Backspace", mods = "CTRL|SHIFT",      action = act.ResetFontSize },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "ALT|SHIFT",
    action = act.ActivateTab(i - 1)
  })
end

config.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h",      action = act.MoveTabRelative(-1) },
    { key = "j",      action = act.MoveTabRelative(-1) },
    { key = "k",      action = act.MoveTabRelative(1) },
    { key = "l",      action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

-- Tab bar
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
wezterm.on("update-status", function(window, pane)
  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = "#f7768e"
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = "#7dcfff"
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = "#bb9af7"
  end

  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  if cwd then
    if type(cwd) == "userdata" then
      -- Wezterm introduced the URL object in 20240127-113634-bbcac864
      cwd = basename(cwd.file_path)
    else
      -- 20230712-072601-f4abf8fd or earlier version
      cwd = basename(cwd)
    end
  else
    cwd = ""
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
  cmd = cmd and basename(cmd) or ""

  -- Time
  local time = wezterm.strftime("%H:%M")

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = "  " },
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " |" },
  }))

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Foreground = { Color = "#e0af68" } },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = "  " },
  }))
end)

-- config.enable_tab_bar = false
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',

}

-- Zen mode plugin from Neovim
wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

return config
