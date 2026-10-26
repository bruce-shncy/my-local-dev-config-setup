local wezterm = require ("wezterm");

local config = wezterm.config_builder();
local act = wezterm.action

config.color_scheme = "Greenscreen (dark) (terminal.sexy)";
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 15.0 
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
config.show_tabs_in_tab_bar = true
config.tab_bar_at_bottom = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_max_width = 25
config.initial_cols = 150
config.initial_rows = 40
config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.6,
    hue = 1.2
}

config.keys = {
    -- Fullscreen toggle
    {
        key = 'f',
        mods = 'CMD',
        action = act.ToggleFullScreen
    },
    {
        key = 'q',
        mods = 'CMD',
        action = act.QuitApplication
    },
    -- PANE SELECTION 
    {
        key = '8', 
        mods = 'CMD', 
        action = act.PaneSelect
    },
    {
        key = '9',
        mods = 'CMD',
        action = act.PaneSelect {
            alphabet = '1234567890'
        }
    },
    {
        key = '0',
        mods = 'CMD',
        action = act.PaneSelect {
            mode  = 'SwapWithActive'
        }
    },
    -- Shift+Enter sends Alt+Enter (new line in Claude Code)
    {
        key = 'Enter',
        mods = 'SHIFT',
        action = act.SendKey { key = 'Enter', mods = 'ALT' }
    },
    -- ADD PANE --
    {
        key = "LeftArrow",
        mods = "CMD",
        action = act.SplitPane { direction = 'Left' }
    },
    {
        key = "RightArrow",
        mods = "CMD",
        action = act.SplitPane { direction = 'Right' }
    },
    {
        key = "UpArrow",
        mods = "CMD",
        action = act.SplitPane { direction = 'Up' }
    },
    {
        key = "DownArrow",
        mods = "CMD",
        action = act.SplitPane { direction = 'Down' }
    },

    -- NAVIGATE THROUGH PANES

    {
        key = "LeftArrow",
        mods = "ALT",
        action = act.ActivatePaneDirection('Left')
    },

    {
        key = "RightArrow",
        mods = "ALT",
        action = act.ActivatePaneDirection("Right")
    },

    {
        key = "UpArrow",
        mods = "ALT",
        action = act.ActivatePaneDirection("Up")
    },

    {
        key = "DownArrow",
        mods = "ALT",
        action = act.ActivatePaneDirection("Down")
    },

    {
        key = "w",
        mods = "CMD",
        action = act.CloseCurrentPane { confirm = true }
    },

    {
        key = "n",
        mods = "CMD|SHIFT",
        action = act.PromptInputLine {
            description =  'Enter a new table title',
            action = wezterm.action_callback(function (window, pane, line)
                if line then 
                    window:active_tab():set_title(line)
                end
            end)
        }
    },

    {
        key = "LeftArrow",
        mods = "SHIFT",
        action = act.ActivateTabRelative(-1)
    },
    {
        key = "RightArrow",
        mods = "SHIFT",
        action = act.ActivateTabRelative(1)
    }

}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
      local title = tab.tab_title
      -- If the tab title is set, use it
      if title and #title > 0 then
          return title
      end
      -- Otherwise, use the active pane's title
      return tab.active_pane.title
  end)
return config