{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions.url = "github:vicinaehq/extensions";
  };

  nawa.apps._.vicinae = {
    homeManager =
      { pkgs, ... }:
      {
        nix.settings = {
          substituters = [ "https://vicinae.cachix.org" ];
          trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
        };
        imports = [ inputs.vicinae.homeManagerModules.default ];
        services.vicinae = {
          enable = true;
          systemd = {
            enable = true;
            autoStart = true;
            environment = {
              USE_LAYER_SHELL = 1;
            };
          };
          settings = {
            font = {
              normal = {
                size = 12;
                family = "Maple Mono NF";
              };
            };
            extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
              nix
              noctalia-shell-wallpaper-selector
              aria2-manager
            ];
          };
        };
      };
  };
}
