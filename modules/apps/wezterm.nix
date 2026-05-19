{ lib, ... }:
{
  nawa.apps._.wezterm = {
    homeManager =
      { config, ... }:
      {
        programs.wezterm =
          let
            inherit (config.stylix) fonts;
            inherit (config.lib.stylix.colors)
              base00
              base01
              base03
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              ;
          in
          {
            enable = true;
            settings = {
              color_scheme = "stylix";
              font = lib.generators.mkLuaInline ''wezterm.font_with_fallback { "${fonts.monospace.name}", "${fonts.emoji.name}" }'';
              font_size = fonts.sizes.terminal;
              line_height = 1.2;
              force_reverse_video_cursor = true;
              use_resize_increments = true;
              enable_tab_bar = false;
              bidi_enabled = true;
              window_padding = {
                left = 4;
                right = 4;
                top = 4;
                bottom = 0;
              };
              keys = [
                {
                  key = "Enter";
                  mods = "ALT";
                  action = lib.generators.mkLuaInline "wezterm.action.DisableDefaultAssignment";
                }
              ];
              window_frame = {
                active_titlebar_bg = base03;
                active_titlebar_fg = base05;
                active_titlebar_border_bottom = base03;
                border_left_color = base01;
                border_right_color = base01;
                border_bottom_color = base01;
                border_top_color = base01;
                button_bg = base01;
                button_fg = base05;
                button_hover_bg = base05;
                button_hover_fg = base03;
                inactive_titlebar_bg = base01;
                inactive_titlebar_fg = base05;
                inactive_titlebar_border_bottom = base03;
              };
              colors = {
                tab_bar = {
                  background = base01;
                  inactive_tab_edge = base01;
                  active_tab = {
                    bg_color = base00;
                    fg_color = base05;
                  };
                  inactive_tab = {
                    bg_color = base03;
                    fg_color = base05;
                  };
                  inactive_tab_hover = {
                    bg_color = base05;
                    fg_color = base00;
                  };
                  new_tab = {
                    bg_color = base03;
                    fg_color = base05;
                  };
                  new_tab_hover = {
                    bg_color = base05;
                    fg_color = base00;
                  };
                };
              };
              command_palette_bg_color = base01;
              command_palette_fg_color = base05;
              command_palette_font_size = fonts.sizes.popups;
            };
            colorSchemes.stylix = {
              ansi = [
                base00
                base08
                base0B
                base0A
                base0D
                base0E
                base0C
                base05
              ];
              brights = [
                base03
                base08
                base0B
                base0A
                base0D
                base0E
                base0C
                base07
              ];
              background = base00;
              cursor_bg = base05;
              cursor_fg = base00;
              compose_cursor = base06;
              foreground = base05;
              scrollbar_thumb = base01;
              selection_bg = base05;
              selection_fg = base00;
              split = base03;
              visual_bell = base09;
              tab_bar = {
                background = base01;
                inactive_tab_edge = base01;
                active_tab = {
                  bg_color = base00;
                  fg_color = base05;
                };
                inactive_tab = {
                  bg_color = base03;
                  fg_color = base05;
                };
                inactive_tab_hover = {
                  bg_color = base05;
                  fg_color = base00;
                };
                new_tab = {
                  bg_color = base03;
                  fg_color = base05;
                };
                new_tab_hover = {
                  bg_color = base05;
                  fg_color = base00;
                };
              };
            };
          };
      };
  };
}
