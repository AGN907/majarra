{ inputs, nawa, ... }:
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
          base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
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
          cursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 32;
          };
          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
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
        stylix.targets.fish = mkEnable config.programs.fish.enable;
        stylix.targets.zellij = mkEnable config.programs.zellij.enable;
        stylix.targets.yazi = mkEnable config.programs.yazi.enable;
        stylix.targets.starship = mkEnable config.programs.starship.enable;
        stylix.targets.kitty = mkEnable config.programs.kitty.enable;
        stylix.targets.bat = mkEnable config.programs.bat.enable;
        stylix.targets.lazygit = mkEnable config.programs.lazygit.enable;
        stylix.targets.vicinae = mkEnable config.services.vicinae.enable;
        stylix.targets.noctalia-shell = mkEnable config.programs.noctalia-shell.enable;
      };
  };
}
