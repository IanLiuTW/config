local wezterm = require("wezterm")
local act = wezterm.action

local shell_path = "/bin/zsh"

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- Settings
config.default_prog = { shell_path, "-l" }

config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  { family = "CommitMono Nerd Font",  scale = 1.3 },
  { family = "CaskaydiaCove Nerd Font Mono", scale = 1.3, },
})
config.window_background_opacity = 0.9
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
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
  { key = "q",          mods = "LEADER|CTRL", action = act.SendKey { key = "q", mods = "CTRL" } },
  { key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
  { key = "F1",         mods = "LEADER",      action = act.ActivateCommandPalette },

  -- Pane keybindings
  { key = "s",          mods = "LEADER|ALT",  action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "v",          mods = "LEADER|ALT",  action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h",          mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Left") },
  { key = "j",          mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Down") },
  { key = "k",          mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Up") },
  { key = "l",          mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Right") },
  { key = "q",          mods = "LEADER|ALT",  action = act.CloseCurrentPane { confirm = true } },
  { key = "z",          mods = "LEADER|ALT",  action = act.TogglePaneZoomState },
  { key = "g",          mods = "LEADER|ALT",  action = act.RotatePanes "Clockwise" },
  { key = "r",          mods = "LEADER|ALT",  action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- Tab keybindings
  { key = "t",          mods = "LEADER|ALT",  action = act.SpawnTab("CurrentPaneDomain") },
  { key = ",",          mods = "LEADER|ALT",  action = act.ActivateTabRelative(-1) },
  { key = ".",          mods = "LEADER|ALT",  action = act.ActivateTabRelative(1) },
  { key = "e",          mods = "LEADER|ALT",  action = act.ShowTabNavigator },
  { key = "w",          mods = "LEADER|ALT",  action = wezterm.action.CloseCurrentTab { confirm = true } },
  {
    key = "R",
    mods = "LEADER|ALT",
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
  { key = "m", mods = "LEADER|ALT",           action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  { key = "<", mods = "LEADER|SHIFT|ALT",     action = act.MoveTabRelative(-1) },
  { key = ">", mods = "LEADER|SHIFT|ALT",     action = act.MoveTabRelative(1) },

  -- Lastly, workspace
  { key = "`", mods = "LEADER",               action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER|ALT",
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
