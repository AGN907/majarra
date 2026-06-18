{
  self,
  inputs,
  nawa,
  ...
}:
let
  # TODO: There's most be a better way to pass stylix colors to perSystem
  stylixColors = self.nixosConfigurations.alkaid.config.lib.stylix.colors.withHashtag;
in
{
  nawa.apps._.niri.includes = [
    nawa.apps._.noctalia
    nawa.apps._.vicinae
  ];

  nawa.apps._.niri = {
    nixos = { pkgs, lib, ... }: {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
        useNautilus = false;
      };

      environment.systemPackages = with pkgs; [
        wl-clipboard-rs
        xwayland-satellite
      ];

      services.gnome.gnome-keyring.enable = lib.mkForce false;

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config.common.default = "*";
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
        config.niri = {
          default = lib.mkDefault [
            "gtk"
            "gnome"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        };
      };
    };
  };

  den.aspects.flake.packages =
    {
      pkgs,
      lib,
      ...
    }:
    {
      niri = inputs.wrappers.wrappers.niri.wrap {
        inherit pkgs;

        settings = {
          binds = import ./_bindings.nix { inherit lib; };
          window-rules = import ./_rules.nix;
          layer-rules = [
            {
              matches = [ { namespace = "^noctalia-backdrop"; } ];
              place-within-backdrop = true;
            }
          ];
          outputs."HDMI-A-1" = {
            mode = "1920x1080@60.00";
            scale = 1.0;
            position = _: {
              props = {
                x = 1280;
                y = 0;
              };
            };
          };
          spawn-at-startup =
            let
              command = cmd: lib.lists.flatten [ cmd ];
            in
            [
              (command "noctalia")
              (command "zen-beta")
            ];
          input.keyboard.xkb = {
            layout = "us,ara";
            options = "grp:alt_shift_toggle";
          };
          layout = {
            border = {
              width = 1;
              active-color = stylixColors.base0D;
              inactive-color = stylixColors.base03;
            };
            shadow = {
              softness = 30;
              spread = 5;
              color = "#0007";
              offset = _: {
                props = {
                  x = 0;
                  y = 5;
                };
              };
            };
            focus-ring.off = _: { };
            preset-column-widths = [
              { proportion = 1.0; }
              { proportion = 1.0 / 2.0; }
              { proportion = 1.0 / 3.0; }
              { proportion = 1.0 / 4.0; }
            ];
            default-column-width = {
              proportion = 0.5;
            };
            background-color = "transparent";
            gaps = 8;
          };

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;
        };
      };
    };
}
