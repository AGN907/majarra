{ ... }:
{
  nawa.apps._.kitty = {
    homeManager = {
      programs.kitty = {
        enable = true;
        font = {
          name = "Maple Mono NF";
          size = 14;
        };
        settings = {
          confirm_os_window_close = 0;
          dynamic_background_opacity = true;
          enable_audio_bell = false;
          mouse_hide_wait = "-1.0";
          window_padding_width = 10;
          cursor_shape = "beam";
          cursor_trail = 100;
        };
      };
    };
  };
}
