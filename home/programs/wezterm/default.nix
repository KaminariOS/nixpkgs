{ pkgs, ... }: {
  xdg.configFile."wezterm/bar.lua".source = ./bar.lua;
  programs.wezterm = {
    enable = true;
    extraConfig = ''
               -- Pull in the wezterm API
               local wezterm = require 'wezterm'

               local disabled_new_tab = {
                 new_tab = "",
                 new_tab_hover = "",
               }
               -- This table will hold the configuration.
               local config = {}

               require("bar").setup({})

               -- In newer versions of wezterm, use the config_builder which will
               -- help provide clearer error messages
               if wezterm.config_builder then
                 config = wezterm.config_builder()
               end

               -- This is where you actually apply your config choices

               -- For example, changing the color scheme:
               config.color_scheme = 'Catppuccin Mocha'

               config.window_background_opacity = 0.7

               -- config.font = wezterm.font('Fira Code', { })
               config.font_size = 32
               config.font = wezterm.font_with_fallback {
               }


               config.window_frame = {
                 -- The font used in the tab bar.
                 -- Roboto Bold is the default; this font is bundled
                 -- with wezterm.
                 -- Whatever font is selected here, it will have the
                 -- main font setting appended to it to pick up any
                 -- fallback fonts you may have used there.
                 font = wezterm.font { family = 'Jetbrains Mono', weight = 'Bold' },

                 -- The size of the font in the tab bar.
                 -- Default to 10.0 on Windows but 12.0 on other systems
                 font_size = 14.0,

                 -- The overall background color of the tab bar when
                 -- the window is focused
                 active_titlebar_bg = '#282C34',

                 -- The overall background color of the tab bar when
                 -- the window is not focused
                 inactive_titlebar_bg = '#333333',
                 -- inactive_titlebar_bg = 'rgba(255, 0, 0, 0)',
               }
          
           config.enable_tab_bar = true
           config.use_fancy_tab_bar = not true
           config.hide_tab_bar_if_only_one_tab = true
           config.tab_bar_at_bottom = true
           config.tab_max_width = 36
           config.tab_bar_style = disabled_new_tab
           config.adjust_window_size_when_changing_font_size = false

           config.xim_im_name = 'fcitx'
           config.use_ime = true

           config.colors = {
             tab_bar = {
          -- The color of the strip that goes along the top of the window
           -- (does not apply when fancy tab bar is in use)
               background = "rgba(0, 0, 0 , 0)",
               -- The color of the inactive tab bar edge/divider
               inactive_tab_edge = '#575757',
             },
           }

           config.default_cursor_style = "BlinkingBar"

           -- Spawn a fish shell in login mode
           -- config.default_prog = { os.getenv( "HOME" ).. '/.nix-profile/bin/fish', '-l' }


           -- https://github.com/wez/wezterm/discussions/2691
           local act = wezterm.action
           config.keys = {
        {
          key='t', mods='CTRL', action = wezterm.action_callback(function(window, pane)
            local mux_window = window:mux_window()

            -- determine the index of the current tab
            -- https://wezfurlong.org/wezterm/config/lua/mux-window/tabs_with_info.html
            local tabs = mux_window:tabs_with_info()
            local current_index = 0
            for _, tab_info in ipairs(tabs) do
              if tab_info.is_active then
                current_index = tab_info.index
                break
              end
            end

            -- spawn a new tab; it will be made active
            -- https://wezfurlong.org/wezterm/config/lua/mux-window/spawn_tab.html
            mux_window:spawn_tab{}

            -- Move the new active tab to the right of the previously active tab
            window:perform_action(act.MoveTab(current_index+1), pane)
          end)
        }
      }
      
          config.window_padding = {
            left = '0.2cell',
            right = '0.2cell',
            top = '0.2cell',
            bottom = '0.1cell',
          }

           -- and finally, return the configuration to wezterm
           return config
    '';
  };
}
