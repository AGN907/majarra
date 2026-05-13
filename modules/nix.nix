{ inputs, ... }:
{
  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.default = {
    nixos = {
      nix = {
        optimise.automatic = true;
        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        };
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
          trusted-users = [
            "@wheel"
            "root"
          ];
          auto-optimise-store = true;
        };
      };
      programs.nh = {
        enable = true;
        flake = "/home/agn/majarra";
      };
    };
    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.nix-index-database.homeModules.nix-index ];
        programs.nix-index.enable = true;
        programs.nix-index.enableFishIntegration = true;
        programs.nix-index-database.comma.enable = true;
        home.packages = [
          pkgs.nix-output-monitor
        ];
      };
  };
}
