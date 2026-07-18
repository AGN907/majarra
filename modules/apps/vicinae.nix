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

        home.file.".mozilla/native-messaging-hosts/com.vicinae.vicinae.json".text = builtins.toJSON {
          name = "com.vicinae.vicinae";
          description = "Vicinae Native Messaging Host";
          path = "${inputs.vicinae.packages.${system}.default}/libexec/vicinae/vicinae-browser-link";
          type = "stdio";
          allowed_extensions = [ "firefox@vicinae.com" ];
        };

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
            firefox
            niri
            timer
            nerdfont-search
            player-pilot
          ];
        };
      };
  };
}
