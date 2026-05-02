{ inputs, ... }:
{
  flake-file.inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  systems = [ "x86_64-linux" ];
  perSystem.treefmt.projectRootFile = ".envrc";
  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
    nixf-diagnose.enable = true;
  };
  perSystem.treefmt.settings.global.excludes = [
    "flake.lock"
    ".envrc"
    "**/.gitignore"
    "*/secrets/*"
  ];
}
