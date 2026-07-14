{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nawa.apps._.vicinae = {
    nixos = {
      nix.settings = {
        substituters = [ "https://vicinae.cachix.org" ];
        trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
      };
    };
    homeManager =
      { system, ... }:
      {
        stylix.targets.vicinae.enable = true;

        imports = [ inputs.vicinae.homeManagerModules.default ];
        programs.vicinae = {
          enable = true;
          systemd = {
            enable = true;
            autoStart = true;
            environment = {
              USE_LAYER_SHELL = 1;
            };
          };
          settings = {
            favorites = [
              "clipboard:history"
              "@agn907/bitwarden-rbw:search-vault"
              "@knoopx/vicinae-extension-nix-0:options"
              "@knoopx/vicinae-extension-nix-0:home-manager-options"
            ];
          };
          extensions = with inputs.vicinae-extensions.packages.${system}; [
            nix
            aria2-manager
            github
          ];
        };
      };
  };
}
