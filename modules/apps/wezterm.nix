{ lib, ... }:
{
  nawa.apps._.wezterm = {
    homeManager = {
      stylix.targets.wezterm.enable = true;

      programs.wezterm = {
        enable = true;
        settings = {
          force_reverse_video_cursor = true;
          use_resize_increments = true;
          window_decorations = "NONE";
          enable_tab_bar = false;
          bidi_enabled = true;
          window_padding = {
            left = 8;
            right = 0;
            top = 0;
            bottom = 2;
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
