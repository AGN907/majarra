[
  {
    geometry-corner-radius = 12;
    clip-to-geometry = true;
    tiled-state = true;
    draw-border-with-background = false;

    opacity = 0.85;
    background-effect = {
      blur = true;
    };
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
  {
    matches = [
      {
        app-id = "org.wezfurlong.wezterm";
      }
    ];
  }
  # Floating windows
  {
    matches = [
      {
        app-id = "zen.*";
        title = "^Picture-in-Picture$";
      }
      {
        app-id = "zen.*";
        title = "^Library$";
      }

      {
        app-id = "zen.*";
        title = ".*popup.*";
      }
      {
        app-id = "zen.*";
        title = ".*Authentication.*";
      }
      {
        app-id = "zen.*";
        title = ".*Login.*";
      }
      {
        app-id = "zen.*";
        title = ".*Security.*";
      }
      {
        app-id = "^xdg-desktop-portal$";
      }
      {
        app-id = "zen.*";
        title = "Sign In - Google Accounts — Zen Browser";
      }
      {
        title = "Yazi.*";
      }
    ];
    open-floating = true;
    default-column-width.proportion = 0.5;
    default-window-height.proportion = 0.5;
  }
]
