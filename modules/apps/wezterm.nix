{ lib, ... }:
{
  nawa.apps._.wezterm = {
    homeManager =
      { config, ... }:
      let
        inherit (config.stylix) fonts;
      in
      {
        stylix.targets.wezterm.enable = true;

        programs.wezterm = {
          enable = true;
          settings = {
            font = lib.mkForce (
              lib.generators.mkLuaInline ''
                wezterm.font_with_fallback {
                  { family = "${fonts.monospace.name}",weight = "Regular", italic = true },
                  { family = "${fonts.emoji.name}"}
                }''
            );
            default_cursor_style = "BlinkingBar";
            cursor_blink_rate = 300;
            force_reverse_video_cursor = true;
            use_resize_increments = true;
            window_decorations = "NONE";
            enable_tab_bar = false;
            bidi_enabled = true;
            window_padding = {
              left = "1cell";
              right = "1cell";
              top = "0.5cell";
              bottom = "0.5cell";
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
