{ lib, ... }:
{
  nawa.apps._.wezterm = {
    homeManager = {
      programs.wezterm = {
        enable = true;
        settings = {
          font = lib.generators.mkLuaInline ''wezterm.font("Maple Mono NF", { weight = "Regular", italic = true})'';
          font_size = 14.0;
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
        };
      };
    };
  };
}
