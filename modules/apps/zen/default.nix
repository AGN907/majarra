{
  inputs,
  ...
}:
{
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake/beta";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nawa.apps._.zen.homeManager =
    { pkgs, system, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      nixpkgs.overlays = [
        (_final: _prev: {
          zen-browser = inputs.zen-browser.packages.x86_64-linux.default;
        })
      ];

      stylix.targets.zen-browser = {
        enable = true;
        profileNames = [ "default" ];
      };

      programs.zen-browser = {
        enable = true;
        package = pkgs.zen-browser;
        setAsDefaultBrowser = true;
        enablePrivateDesktopEntry = true;
        nativeMessagingHosts = [
          (pkgs.writeTextDir "lib/mozilla/native-messaging-hosts/com.vicinae.vicinae.json" (
            builtins.toJSON {
              name = "com.vicinae.vicinae";
              description = "Vicinae Native Messaging Host";
              path = "${inputs.vicinae.packages.${system}.default}/libexec/vicinae/vicinae-browser-link";
              type = "stdio";
              allowed_extensions = [ "firefox@vicinae.com" ];
            }
          ))
        ];
        policies = import ./_polices.nix;
        profiles.default = import ./_profile-default.nix { inherit pkgs; };
      };

      # Open files with the browser
      xdg.mimeApps =
        let
          associations = builtins.listToAttrs (
            map
              (name: {
                inherit name;
                value = "zen-beta.desktop";
              })
              [
                "application/x-extension-shtml"
                "application/x-extension-xhtml"
                "application/x-extension-html"
                "application/x-extension-xht"
                "application/x-extension-htm"
                "x-scheme-handler/unknown"
                "x-scheme-handler/mailto"
                "x-scheme-handler/chrome"
                "x-scheme-handler/about"
                "x-scheme-handler/https"
                "x-scheme-handler/http"
                "application/xhtml+xml"
                "application/json"
                "text/plain"
                "text/html"
              ]
          );
        in
        {
          enable = true;
          associations.added = associations;
          defaultApplications = associations;
        };
    };
}
