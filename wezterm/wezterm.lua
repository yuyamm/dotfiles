local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.default_cwd = "/Users/yuyamm"
config.use_ime = true
config.audible_bell = "Disabled"

----------------------------------------------------
-- Scroll
----------------------------------------------------
config.enable_scroll_bar = false
config.scrollback_lines = 3500

----------------------------------------------------
-- Tab
----------------------------------------------------
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
    options = {
        theme = "Gruvbox dark, hard (base16)",
        tab_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = "",
        },
        theme_overrides = {
            tab = {
                active = { fg = "#1d2021", bg = "#83a598" },
            },
        },
    },
    sections = {
        tab_active = {
            "index",
            { "process", padding = { left = 0, right = 1 } },
            "",
            { "cwd",     padding = { left = 1, right = 0 } },
            { "zoomed",  padding = 1 },
        },
        tab_inactive = {
            "index",
            { "process", padding = { left = 0, right = 1 } },
            "󰉋",
            { "cwd",     padding = { left = 1, right = 0 } },
            { "zoomed",  padding = 1 },
        },
        tabline_x = {},
        tabline_y = {},
        tabline_z = {},
    },
})

tabline.apply_to_config(config)

-- override tabline.wez
config.window_decorations = "TITLE | RESIZE"
config.show_tabs_in_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 100

----------------------------------------------------
-- Paint
----------------------------------------------------
config.initial_rows = 40
config.initial_cols = 140
config.font_size = 14.0
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_padding = {
    -- auto padding
}

----------------------------------------------------
-- Font
----------------------------------------------------
config.font = wezterm.font 'FiraCode Nerd Font'

----------------------------------------------------
-- Keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

return config

