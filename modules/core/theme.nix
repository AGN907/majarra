{ inputs, nawa, ... }:
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix";

  nawa.core.includes = [ nawa.core._.theme ];

  nawa.core._.theme = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];
        fonts = {
          packages = with pkgs; [
            maple-mono.NF
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            nerd-fonts.symbols-only
            liberation_ttf
            inter
          ];
          enableDefaultPackages = true;
          fontDir.enable = true;
          fontconfig.defaultFonts = {
            serif = [ "Liberation Serif" ];
            sansSerif = [ "Inter" ];
            monospace = [ "Maple Mono NF" ];
          };
        };
      };
    homeManager = {
      imports = [ inputs.stylix.homeModules.stylix ];
    };
  };
}
