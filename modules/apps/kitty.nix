{ ... }:
{
  nawa.apps._.kitty = {
    homeManager = {
      programs.kitty = {
        enable = true;
        settings = {
          confirm_os_window_close = 0;
          dynamic_background_opacity = true;
          enable_audio_bell = false;
          window_padding_width = 10;
          cursor_shape = "beam";
          cursor_trail = 3;
          scrollback_lines = 10000;
          copy_on_select = "clipboard";
        };
      };
    };
  };
}
