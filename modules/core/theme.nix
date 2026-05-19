{ inputs, nawa, ... }:
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix";

  nawa.core.includes = [ nawa.core._.theme ];

  nawa.core._.theme = {
    nixos =
      { pkgs, lib, ... }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];

        stylix = {
          enable = true;
          autoEnable = false;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
          polarity = "dark";
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
            size = 28;
          };
          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
          };

          targets = {
            gtk.enable = true;
            qt = {
              enable = true;
              platform = lib.mkForce "gnome";
            };
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
        stylix.targets = {
          qt.enable = true;
          gtk.enable = true;
          fish = mkEnable config.programs.fish.enable;
          zellij = mkEnable config.programs.zellij.enable;
          yazi = mkEnable config.programs.yazi.enable;
          starship = mkEnable config.programs.starship.enable;
          wezterm = mkEnable config.programs.wezterm.enable;
          bat = mkEnable config.programs.bat.enable;
          lazygit = mkEnable config.programs.lazygit.enable;
          vicinae = mkEnable config.services.vicinae.enable;
          noctalia-shell = mkEnable config.programs.noctalia-shell.enable;
        };
      };
  };
}
