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
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.zen-browser.homeModules.twilight
      ];

      stylix.targets.zen-browser = {
        enable = true;
        profileNames = [ "default" ];
      };

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        enablePrivateDesktopEntry = true;
        env = {
          GTK_THEME = "Adwaita";
        };
        policies = import ./_polices.nix;
        profiles.default = import ./_profile-default.nix { inherit pkgs; };
      };

      xdg.mimeApps =
        let
          associations = builtins.listToAttrs (
            map
              (name: {
                inherit name;
                value = "zen-twilight.desktop";
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
