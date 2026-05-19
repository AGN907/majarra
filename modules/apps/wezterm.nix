{ lib, ... }:
{
  nawa.apps._.wezterm = {
    homeManager = {
      programs.wezterm = {
        enable = true;
        settings = {
          line_height = 1.2;
          force_reverse_video_cursor = true;
          use_resize_increments = true;
          enable_tab_bar = false;
          bidi_enabled = true;
          window_padding = {
            left = 0;
            right = 0;
            top = 0;
            bottom = 0;
          };
          keys = [
            {
              key = "Enter";
              mods = "ALT";
              action = lib.generators.mkLuaInline "wezterm.action.DisableDefaultAssignment";
            }
          ];
        };
      };
    };
  };
}
