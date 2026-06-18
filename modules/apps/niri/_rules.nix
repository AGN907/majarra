[
  {
    geometry-corner-radius = 12;
    clip-to-geometry = true;
    draw-border-with-background = false;
    opacity = 0.90;
  }
  {
    background-effect = {
      blur = true;
    };
  }
  {
    matches = [
      {
        app-id = "org.wezfurlong.wezterm";
      }
    ];
    default-column-width = { };
  }
  {
    matches = [
      {
        app-id = "zen.*";
      }
    ];
    default-column-width = {
      proportion = 1.0;
    };

    opacity = 1.0;
  }
  # Floating windows
  {
    matches = [
      {
        title = "^Picture-in-Picture$";
      }
      {
        app-id = "zen.*";
        title = "^Library$";
      }
      {
        app-id = "^xdg-desktop-portal$";
      }
    ];
    open-floating = true;
    default-column-width.proportion = 0.5;
    default-window-height.proportion = 0.5;
  }
]
