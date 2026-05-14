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
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
      in
      {
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
          };
          extensions = with inputs.vicinae-extensions.packages.${system}; [
            nix
            aria2-manager
          ];
        };
      };
  };
}
