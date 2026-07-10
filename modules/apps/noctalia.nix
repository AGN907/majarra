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
      let
        inherit (config.stylix) fonts opacity;
      in
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        stylix.targets.noctalia.enable = true;

        programs.noctalia = {
          enable = true;
          settings = {
            shell = {
              font_family = fonts.sansSerif.name;
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
            bar = {
              main = {
                enabled = true;
                position = "top";
                background_opacity = opacity.desktop;
                capsule_opacity = opacity.desktop;
                widget_spacing = 6;
                margin_ends = 120;
                start = [
                  "launcher"
                  "spacer"
                  "workspaces"
                  "spacer"
                  "active_window"
                ];
                center = [
                  "wallpaper"
                  "clock"
                  "notifications"
                ];
                end = [
                  "media"
                  "spacer"
                  "tray"
                  "spacer"
                  "group:group1"
                  "session"
                ];
                capsule_group = [
                  {
                    id = "group1";
                    fill = "surface_variant";
                    members = [
                      "network"
                      "volume"
                      "keyboard_layout"
                    ];
                    padding = 8;
                    opacity = opacity.desktop;
                  }
                ];
              };
            };
            audio = {
              enable_overdrive = true;
            };
            notification = {
              enable_daemon = true;
              position = "top_right";
            };
            weather = {
              enabled = true;
              unit = "metric";
            };
            location = {
              address = "Dammam, SA";
            };
            lockscreen = {
              blurred_desktop = true;
              blur_intensity = 0.20;
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
              network = {
                show_label = false;
              };
              keyboard_layout = {
                show_label = false;
              };
            };
          };
        };
      };
  };
}
