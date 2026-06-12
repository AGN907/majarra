{
  inputs,
  ...
}:
{
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia-shell";

  nawa.apps._.noctalia = {
    nixos = {
      nix.settings = {
        substituters = [ "https://noctalia.cachix.org" ];
        trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
    };

    homeManager =
      { config, ... }:
      {
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
              panel = {
                transparency_mode = "glass";
              };
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
                  action = "lock_and_suspend";
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
              screenshot = {
                save_to_file = true;
                directory = "${config.xdg.userDirs.pictures}/Screenshots";
                filename_pattern = "screenshot_%Y%m%d_%H%M%S";
              };
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
                widget_spacing = 6;
                margin_ends = 120;
                start = [
                  "launcher"
                  "spacer"
                  "wallpaper"
                  "spacer"
                  "workspaces"
                  "spacer"
                  "active_window"
                ];
                center = [ "clock" ];
                end = [
                  "media"
                  "spacer"
                  "tray"
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
              unit = "metric";
            };
            lockscreen = {
              blurred_desktop = true;
            };
            backdrop = {
              enabled = true;
            };
            widget = {
              clock = {
                format = "{:%H:%M} - {:%b %e %a}";
              };
              volume = {
                show_label = false;
              };
              media = {
                hide_when_no_media = true;
              };
            };
          };
        };
      };
  };
}
