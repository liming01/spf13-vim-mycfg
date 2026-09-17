-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local act = wezterm.action

-- This is where you actually apply your config choices

-- lanuch zsh by default
--config.default_prog = { "/usr/bin/zsh", "-l" }

-- The initial window size when launching wezterm
config.initial_cols = 120
config.initial_rows = 35

config.detect_password_input = true

-- color_schemes
-- dark
--config.color_scheme = "Apple Classic"
-- config.color_scheme = "Chester"
-- config.color_scheme = "DanQing (base16)"
-- config.color_scheme = "Zenburn"
-- config.color_scheme = "Unikitty Reversible (base16)"
-- config.color_scheme = "Sakura"
-- config.color_scheme = "Pasque (base16)"
-- config.color_scheme = "Obsidian"
-- config.color_scheme = "3024 (base16)"
-- config.color_scheme = "Mariana"
--
-- config.color_scheme = "midnight-in-mojave"
-- config.color_scheme = "Cobalt 2 (Gogh)"
-- config.color_scheme = "Cobalt Neon"
-- config.color_scheme = "Galaxy"
-- config.color_scheme = "Gruvbox Dark (Gogh)"

-- config.color_scheme = "Mariana"

-- config.color_scheme = "Toy Chest (Gogh)"

-- light
-- config.color_scheme = "Builtin Solarized Light"
-- config.color_scheme = "dawnfox"
-- config.color_scheme = "Catppuccin Latte"
-- config.color_scheme = "Default (light) (terminal.sexy)"
-- config.color_scheme = "Mocha (light) (terminal.sexy)"
-- config.color_scheme = "purplepeter"
-- config.color_scheme = "Novel"

-- config.font = wezterm.font("Hack Nerd Font Mono")
-- config.font = wezterm.font("FiraCode Nerd Font Mono")
-- config.font = wezterm.font("Cascadia Code")

-- config.window_background_gradient = {
-- 	colors = { "black", "grey" },
-- 	orientation = {
-- 		Radial = {
-- 			-- Specifies the x coordinate of the center of the circle,
-- 			-- in the range 0.0 through 1.0.  The default is 0.5 which
-- 			-- is centered in the X dimension.
-- 			cx = 0.5,
--
-- 			-- Specifies the y coordinate of the center of the circle,
-- 			-- in the range 0.0 through 1.0.  The default is 0.5 which
-- 			-- is centered in the Y dimension.
-- 			cy = 0.5,
--
-- 			-- Specifies the radius of the notional circle.
-- 			-- The default is 0.5, which combined with the default cx
-- 			-- and cy values places the circle in the center of the
-- 			-- window, with the edges touching the window edges.
-- 			-- Values larger than 1 are possible.
-- 			radius = 1.0,
-- 		},
-- 	},
-- }

-- background
-- config.win32_system_backdrop = "Acrylic"
-- config.window_background_opacity = 0.9
-- config.window_background_image = "./2.jpg"
--config.background = {
--	{
--		source = {
--			File = "/home/shaoran/Pictures/dark/6.jpg",
--		},
--		height = "Cover",
--		-- opacity = 0.5,
--		hsb = {
--			brightness = 0.05,
--			-- hue = 0.5,
--			-- saturation = 0.5,
--		},
--	},
--}
------------ 窗口透明 / 模糊（跨平台）----------
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0

-- macOS 毛玻璃
if wezterm.target_triple:find("apple") then
  config.macos_window_background_blur = 20
end

-- Windows 亚克力
if wezterm.target_triple:find("windows") then
  config.win32_acrylic_accent_color = "rgba(30, 30, 40, 0.9)"
end

config.font = wezterm.font_with_fallback({
	{ family = "Monaco", weight = "Regular" },
	"Hack Nerd Font Mono",
	"JetBrainsMono Nerd Font Mono",
	"SpaceMono Nerd Font Mono",
	"UbuntuMono Nerd Font Mono",
	"Terminess Nerd Font Mono",
	"CodeNewRoman Nerd Font Mono",
	"Hurmit Nerd Font Mono",
	-- "Cascadia Mono",
	-- Chinese font
	"LXGW WenKai Mono",
	"Noto Sans CJK SC",
	"DengXian",
	{ family = "JetBrains Mono Nerd Font", weight = "Medium" },
	{ family = "Fira Code Nerd Font" },
	"Noto Color Emoji",
	"Microsoft YaHei", -- Windows 中文
	"PingFang SC",     -- macOS 中文
})
config.font_size = 14.0
config.line_height = 1.1
config.cell_width = 1.0

config.window_decorations = "RESIZE" -- 只留缩放边框，无标题栏
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

config.window_close_confirmation = "NeverPrompt"

-- cursor
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_ease_out = "Linear"
config.cursor_blink_rate = 600
config.cursor_thickness = 2

config.colors = {
  cursor_bg = "#a6e3a1",
  cursor_fg = "#11111b",
  selection_bg = "#585b70",
  selection_fg = "#cdd6f4",
}
------ 标签栏（简洁）--------
config.enable_tab_bar = true
--config.use_fancy_tab_bar = false
config.tab_max_width = 24
--config.hide_tab_bar_if_only_one_tab = true

--config.colors.tab_bar = {
--  background = "#181825",
--  active_tab = { bg_color = "#313244", fg_color = "#cdd6f4" },
--  inactive_tab = { bg_color = "#1e1e2e", fg_color = "#7f849c" },
--}


--------- 查找模式内操作 ----------
-- 激活查找（默认）: 
--   Windows/Linux：Ctrl + Shift + F
--   macOS：Cmd + F
-- 下一个匹配：Ctrl + N / Enter / ↓
-- 上一个匹配：Ctrl + P / Shift + Enter / ↑
-- 切换大小写敏感：Ctrl + R
-- 清空搜索框：Ctrl + U
-- 退出查找：Esc

-- keymappings
-- 前缀键（类似 tmux leader）
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }


config.keys = {
  -- 分割窗格
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- 切换窗格
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Next"), },

  -- 标签页
--{ key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
--{ key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = false } },

  -- 调整窗格大小
  { key = 'H', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'J', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { key = 'K', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'L', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },

  -- 全屏
  { key = 'f', mods = 'LEADER', action = wezterm.action.ToggleFullScreen },
  -- 重新加载配置
--{ key = 'r', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
}

-- 滚动
config.scrollback_lines = 10000
config.enable_scroll_bar = true
config.alternate_buffer_wheel_scroll_speed = 3

-- 性能
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 60
config.cursor_blink_rate = 600

-- 后台会话不退出
config.unix_domains = { { name = 'persist' } }
config.default_gui_startup_args = { 'connect', 'persist' }

-- and finally, return the configuration to wezterm
return config
