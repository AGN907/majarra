{
  inputs,
  ...
}:
{
  flake-file.inputs.niri.url = "github:sodiboo/niri-flake";

  nawa.apps._.niri = {
    nixos = {
      nix.settings = {
        substituters = [ "https://niri.cachix.org" ];
        trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
      };
      hardware.graphics = {
        enable = true;
      };
      hardware.nvidia.modesetting.enable = true;
    };
    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.niri.homeModules.niri ];
        programs.niri = {
          enable = true;
          settings = {
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
            };
            layout = {
              border = {
                enable = true;
                width = 2;
              };
              focus-ring.width = 2;
              shadow = {
                softness = 30;
                spread = 5;
                color = "#0007";
                offset = {
                  x = 0;
                  y = 5;
                };
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
            input.keyboard.xkb = {
              options = "grp:alt_shift_toggle";
            };
          };
        };
        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
          config.common.default = "*";
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };
      };
  };
}
