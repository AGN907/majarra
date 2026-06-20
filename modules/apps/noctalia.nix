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
                  mPrimary = base0D;
                  mOnPrimary = base00;
                  mSecondary = base0E;
                  mOnSecondary = base00;
                  mTertiary = base0C;
                  mOnTertiary = base00;
                  mError = base08;
                  mOnError = base00;
                  mSurface = base00;
                  mOnSurface = base05;
                  mHover = base0C;
                  mOnHover = base00;
                  mSurfaceVariant = base01;
                  mOnSurfaceVariant = base05;
                  mOutline = base03;
                  mShadow = base00;
                  terminal = {
                    background = base00;
                    foreground = base05;
                    cursor = base00;
                    cursorText = base05;
                    selectionBg = base00;
                    selectionFg = base05;

                    normal = {
                      black = base00;
                      red = base08;
                      green = base0B;
                      yellow = base0A;
                      blue = base0D;
                      magenta = base0E;
                      cyan = base0C;
                      white = base05;
                    };

                    bright = {
                      black = base01;
                      red = base08;
                      green = base0B;
                      yellow = base09;
                      blue = base0D;
                      magenta = base0E;
                      cyan = base0C;
                      white = base04;
                    };
                  };
                };

                light = with colors.withHashtag; {
                  mPrimary = base0D;
                  mOnPrimary = base00;
                  mSecondary = base0E;
                  mOnSecondary = base00;
                  mTertiary = base0C;
                  mOnTertiary = base00;
                  mError = base08;
                  mOnError = base00;
                  mSurface = base00;
                  mOnSurface = base05;
                  mHover = base0C;
                  mOnHover = base00;
                  mSurfaceVariant = base01;
                  mOnSurfaceVariant = base04;
                  mOutline = base03;
                  mShadow = base00;
                  terminal = {
                    background = base00;
                    foreground = base05;
                    cursor = base00;
                    cursorText = base05;
                    selectionBg = base00;
                    selectionFg = base05;

                    normal = {
                      black = base00;
                      red = base08;
                      green = base0B;
                      yellow = base0A;
                      blue = base0D;
                      magenta = base0E;
                      cyan = base0C;
                      white = base05;
                    };

                    bright = {
                      black = base01;
                      red = base08;
                      green = base0B;
                      yellow = base09;
                      blue = base0D;
                      magenta = base0E;
                      cyan = base0C;
                      white = base04;
                    };
                  };
                };
              };
          };
        };
      };
  };
}
