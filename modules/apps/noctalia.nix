{
  inputs,
  ...
}:
{
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia-shell/v5";

  nawa.apps._.noctalia = {
    nixos = {
      nix.settings = {
        substituters = [ "https://noctalia.cachix.org" ];
        trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
    };

    homeManager = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        settings = {
          shell = {
            font_family = "Maple Mono NF";
            lang = "en_GB";
            polkit_agent = true;
            session.actions = [
              {
                action = "lock";
                shortcut = "L";
              }
              {
                action = "logout";
                shortcut = "E";
              }
              {
                action = "suspend";
                shortcut = "S";
              }
              {
                action = "reboot";
                shortcut = "R";
              }
              {
                action = "shutdown";
                shortcut = "D";
              }
            ];
          };
          theme = {
            mode = "dark";
            source = "community";
            community_palette = "Kanagawa Dragon";
          };
          bar = {
            main = {
              enabled = true;
              position = "top";
              background_opacity = 0.80;
              widget_spacing = 8;
              margin_ends = 120;
              start = [
                "launcher"
                "spacer"
                "wallpaper"
                "spacer"
                "workspaces"
                "active_window"
              ];
              center = [ "clock" ];
              end = [
                "media"
                "spacer"
                "tray"
                "spacer"
                "cpu"
                "ram"
                "spacer"
                "notifications"
                "volume"
                "keyboard_layout"
                "session"
              ];
            };
          };
          notification = {
            enable_daemon = true;
            position = "top_right";
          };
          weather = {
            enabled = true;
            address = "Dammam, SA";
            unit = "metric";
          };
          lockscreen = {
            blurred_desktop = true;
          };
          widget = {
            clock = {
              format = "{:%H:%M} - {:%b %e %a}";
            };
            cpu = {
              type = "sysmon";
              stat = "cpu_usage";
              show_label = false;
            };
            ram = {
              type = "sysmon";
              stat = "ram_used";
              show_label = false;
            };
          };
        };
      };
    };
  };
}
