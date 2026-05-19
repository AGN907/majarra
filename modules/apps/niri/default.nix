{
  inputs,
  nawa,
  ...
}:
{
  flake-file.inputs.niri.url = "github:sodiboo/niri-flake";

  nawa.apps._.niri.includes = [
    nawa.apps._.noctalia
    nawa.apps._.vicinae
  ];

  nawa.apps._.niri = {
    nixos =
      { pkgs, ... }:
      {
        imports = [
          # Enable binary cache, home module, stylix, and etc.
          inputs.niri.nixosModules.niri
        ];
        nixpkgs.overlays = [
          inputs.niri.overlays.niri
        ];

        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };

        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
          config.common.default = "*";
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
          ];
          config.niri = {
            default = [
              "gtk"
              "gnome"
            ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
          };
        };
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages =
          with pkgs;
          [
            wl-clipboard-rs
          ]
          ++ [
            inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable
          ];

        programs.niri.settings = {
          outputs."HDMI-A-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.000;
            };
            scale = 1.0;
            position = {
              x = 1280;
              y = 0;
            };
          };
          spawn-at-startup = [
            { command = [ "noctalia-shell" ]; }
          ];
          prefer-no-csd = true;
          input.keyboard.xkb = {
            layout = "us,ara";
            options = "grp:alt_shift_toggle";
          };
          layout = {
            border = {
              enable = true;
              width = 2;
            };
            shadow = {
              softness = 30;
              spread = 5;
              color = "#0007";
              offset = {
                x = 0;
                y = 5;
              };
            };
            focus-ring = {
              enable = false;
            };
            preset-column-widths = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
            ];
            default-column-width = {
              proportion = 0.5;
            };
            background-color = "transparent";
            gaps = 8;
          };
          window-rules = [
            {
              geometry-corner-radius = {
                bottom-left = 4.0;
                bottom-right = 4.0;
                top-left = 4.0;
                top-right = 4.0;
              };
              clip-to-geometry = true;
              tiled-state = true;
              draw-border-with-background = false;
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
            }
          ];
          layer-rules = [
            {
              matches = [ { namespace = "^noctalia-overview.*"; } ];
              place-within-backdrop = true;
            }
          ];
        };
      };
  };
}
