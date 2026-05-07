{ inputs, nawa, ... }:
let
  kanso = {
    base00 = "#090E13";
    base01 = "#22262D";
    base02 = "#22262D";
    base03 = "#5C6066";
    base04 = "#a4a7a4";
    base05 = "#c5c9c7";
    base06 = "#c5c9c7";
    base07 = "#c5c9c7";
    base08 = "#c4746e";
    base09 = "#b98d7b";
    base0A = "#c4b28a";
    base0B = "#8a9a7b";
    base0C = "#8ea4a2";
    base0D = "#8ba4b0";
    base0E = "#a292a3";
    base0F = "#b98d7b";
  };
in
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix";

  nawa.core.includes = [ nawa.core._.theme ];

  nawa.core._.theme = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];

        stylix = {
          enable = true;
          autoEnable = false;
          base16Scheme = kanso;
          fonts = {
            serif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Serif";
            };
            sansSerif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Sans";
            };
            monospace = {
              package = pkgs.maple-mono.NF;
              name = "Maple Mono NF";
            };
            emoji = {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
            };
          };
          targets = {
            gtk.enable = true;
            qt.enable = true;
          };
        };
        fonts = {
          enableDefaultPackages = true;
          fontDir.enable = true;
        };
      };
    homeManager =
      { config, lib, ... }:
      let
        mkEnable = cond: lib.mkIf cond { enable = true; };
      in
      {
        # stylix.targets.fish = mkEnable config.programs.fish.enable;
        # stylix.targets.zellij = mkEnable config.programs.zellij.enable;
        # stylix.targets.yazi = mkEnable config.programs.yazi.enable;
        # stylix.targets.starship = mkEnable config.programs.starship.enable;
        # stylix.targets.kitty = mkEnable config.programs.kitty.enable;
        # stylix.targets.bat = mkEnable config.programs.bat.enable;
        # stylix.targets.lazygit = mkEnable config.programs.lazygit.enable;
        # stylix.targets.vicinae = mkEnable config.services.vicinae.enable;
        # stylix.targets.noctalia-shell = mkEnable config.programs.noctalia-shell.enable;
      };
  };
}
