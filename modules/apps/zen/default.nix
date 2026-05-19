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
    { pkgs, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];
      nixpkgs.overlays = [
        (_final: _prev: {
          zen-browser = inputs.zen-browser.packages.x86_64-linux.default;
        })
      ];
      home.sessionVariables.BROWSER = "zen-beta";
      programs.zen-browser = {
        enable = true;
        package = pkgs.zen-browser;
        setAsDefaultBrowser = true;
        enablePrivateDesktopEntry = true;
        nativeMessagingHosts = [
          pkgs.kdePackages.plasma-browser-integration
        ];
        profiles.default = {
          settings = {
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.urlbar.behavior" = "float";
            "zen.welcome-screen.seen" = true;
          };
          mods = [
            "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
            "7190e4e9-bead-4b40-8f57-95d852ddc941" # Tab title fixes
          ];
          spacesForce = true;
          spaces = {
            "General" = {
              id = "e966bffb-71b3-4d48-96b7-d53cb75da363";
              position = 1000;
              icon = "🏠";
            };
            "Work" = {
              id = "e87b512a-8f0b-406c-b759-c466ee38b0c7";
              position = 2000;
              icon = "💼";
            };
            "Learning" = {
              id = "6fbf0424-cf43-4a81-9f8c-d293da231f11";
              position = 3000;
              icon = "book";
            };
          };
          pinsForce = true;
          pins = {
            "Github" = {
              id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
              url = "https://github.com";
              position = 101;
            };
          };
          keyboardShortcutsVersion = 18;
          keyboardShortcuts = [
            {
              id = "zen-compact-mode-toggle";
              key = "c";
              modifiers = {
                control = true;
                alt = true;
              };
            }
            {
              id = "key_quitApplication";
              disabled = true;
            }
          ];
        };
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
