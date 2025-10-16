-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- ============================================
-- THEME AND COLORS (from Ghostty)
-- ============================================
config.color_scheme = 'Vercel'

-- ============================================
-- FONT CONFIGURATION
-- ============================================
-- Font size synced from Ghostty (keeping existing font family)
config.font_size = 19

-- ============================================
-- CURSOR SETTINGS (from Ghostty)
-- ============================================
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- ============================================
-- WINDOW APPEARANCE (from Ghostty)
-- ============================================
-- Transparency
config.window_background_opacity = 0.95
config.macos_window_background_blur = 15

-- Window padding (synced from Ghostty)
config.window_padding = {
  left = 12,
  right = 12,
  top = 8,
  bottom = 8,
}

-- Window dimensions (approximate from Ghostty's 35x120)
config.initial_rows = 35
config.initial_cols = 120

-- macOS settings
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
config.native_macos_fullscreen_mode = false
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- ============================================
-- PERFORMANCE (from Ghostty)
-- ============================================
config.scrollback_lines = 500000

-- ============================================
-- BEHAVIOR (from Ghostty)
-- ============================================
-- Mouse
config.hide_mouse_cursor_when_typing = true
config.swallow_mouse_click_on_window_focus = false

-- Selection
config.selection_word_boundary = ' \t\n{}[]()"\'^`'

-- ============================================
-- TAB BAR
-- ============================================
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = true

-- ============================================
-- KEYBOARD SHORTCUTS (from Ghostty)
-- ============================================
config.keys = {
  -- === WINDOW & TAB MANAGEMENT ===
  { key = 'n', mods = 'CMD', action = wezterm.action.SpawnWindow },
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = false } },

  -- Tab navigation (like browser)
  { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = wezterm.action.ActivateTab(-1) },
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(1) },

  -- === SPLIT MANAGEMENT ===
  -- Create splits
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Navigate splits (Arrow keys)
  { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'DownArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- Resize splits
  { key = 'LeftArrow', mods = 'CMD|ALT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'DownArrow', mods = 'CMD|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { key = 'UpArrow', mods = 'CMD|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'RightArrow', mods = 'CMD|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },

  -- Toggle split zoom
  { key = 'Enter', mods = 'CMD|SHIFT', action = wezterm.action.TogglePaneZoomState },

  -- === CLIPBOARD & TEXT MANIPULATION ===
  { key = 'c', mods = 'CMD', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD', action = wezterm.action.PasteFrom 'Clipboard' },

  -- === SEARCH & NAVIGATION ===
  { key = 'f', mods = 'CMD', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
  { key = 'Home', mods = 'CMD', action = wezterm.action.ScrollToTop },
  { key = 'End', mods = 'CMD', action = wezterm.action.ScrollToBottom },
  { key = 'PageUp', mods = 'NONE', action = wezterm.action.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'NONE', action = wezterm.action.ScrollByPage(1) },

  -- === FONT & DISPLAY ===
  { key = '+', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },

  -- Toggle fullscreen
  { key = 'Enter', mods = 'CMD', action = wezterm.action.ToggleFullScreen },
}

-- and finally, return the configuration to wezterm
return config
