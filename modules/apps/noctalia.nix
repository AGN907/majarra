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
            theme = {
              mode = "dark";
              source = "custom";
              custom_palette = "stylix";
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
              background_opacity = opacity.popups;
            };
            osd = {
              background_opacity = opacity.popups;
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
          customPalettes = {
            stylix =
              let
                inherit (config.lib.stylix) colors;
              in
              {
                dark = with colors.withHashtag; {
                  mPrimary = base0B; # #8a9a7b
                  mOnPrimary = base00; # #181616
                  mSecondary = base0C; # #8ea4a2
                  mOnSecondary = base00; # #181616
                  mTertiary = base08; # #c4746e
                  mOnTertiary = base00; # #181616
                  mError = base08; # #c4746e
                  mOnError = base00; # #181616
                  mSurface = base00; # #181616
                  mOnSurface = base05; # #c5c9c5
                  mHover = base02; # #393836
                  mOnHover = base05; # #c5c9c5
                  mSurfaceVariant = base01; # #282727
                  mOnSurfaceVariant = base06; # #c8c093
                  mOutline = base03; # #625e5a
                  mShadow = base00; # #181616

                  terminal = {
                    background = base00; # #181616
                    foreground = base05; # #c5c9c5
                    cursor = base05; # #c5c9c5
                    cursorText = base00; # #181616
                    selectionBg = base05; # #c5c9c5
                    selectionFg = base00; # #181616

                    normal = {
                      black = base01; # #282727
                      red = base08; # #c4746e
                      green = base0B; # #8a9a7b
                      yellow = base0A; # #c4b28a
                      blue = base0D; # #8ba4b0
                      magenta = base0E; # #a292a3
                      cyan = base0C; # #8ea4a2
                      white = base05; # #c5c9c5
                    };

                    bright = {
                      black = base03; # #625e5a
                      red = base08; # #c4746e
                      green = base0B; # #8a9a7b
                      yellow = base09; # #b6927b
                      blue = base0D; # #8ba4b0
                      magenta = base0E; # #a292a3
                      cyan = base0C; # #8ea4a2
                      white = base06; # #c8c093
                    };
                  };
                };

                light = with colors.withHashtag; {
                  mPrimary = base0B; # #8a9a7b
                  mOnPrimary = base05; # #c5c9c5
                  mSecondary = base0C; # #8ea4a2
                  mOnSecondary = base05; # #c5c9c5
                  mTertiary = base08; # #c4746e
                  mOnTertiary = base05; # #c5c9c5
                  mError = base08; # #c4746e
                  mOnError = base05; # #c5c9c5
                  mSurface = base05; # #c5c9c5
                  mOnSurface = base00; # #181616
                  mHover = base06; # #c8c093
                  mOnHover = base00; # #181616
                  mSurfaceVariant = base06; # #c8c093
                  mOnSurfaceVariant = base00; # #181616
                  mOutline = base0B; # #8a9a7b
                  mShadow = base04; # #737c73

                  terminal = {
                    background = base05; # #c5c9c5
                    foreground = base00; # #181616
                    cursor = base00; # #181616
                    cursorText = base05; # #c5c9c5
                    selectionBg = base00; # #181616
                    selectionFg = base05; # #c5c9c5

                    normal = {
                      black = base05; # #c5c9c5
                      red = base08; # #c4746e
                      green = base0B; # #8a9a7b
                      yellow = base0A; # #c4b28a
                      blue = base0D; # #8ba4b0
                      magenta = base0E; # #a292a3
                      cyan = base0C; # #8ea4a2
                      white = base00; # #181616
                    };

                    bright = {
                      black = base04; # #737c73
                      red = base08; # #c4746e
                      green = base0B; # #8a9a7b
                      yellow = base09; # #b6927b
                      blue = base0D; # #8ba4b0
                      magenta = base0E; # #a292a3
                      cyan = base0C; # #8ea4a2
                      white = base01; # #282727
                    };
                  };
                };
              };
          };
        };
      };
  };
}
