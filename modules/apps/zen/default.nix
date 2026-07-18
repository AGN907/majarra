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
      config,
      pkgs,
      system,
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
    };
}
