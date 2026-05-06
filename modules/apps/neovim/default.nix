{ inputs, ... }:
{
  flake-file.inputs = {
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";

    plugins-lze = {
      url = "github:BirdeeHub/lze";
      flake = false;
    };
    plugins-lzextras = {
      url = "github:BirdeeHub/lzextras";
      flake = false;
    };
    plugins-kanso = {
      url = "github:webhooked/kanso.nvim";
      flake = false;
    };
    plugins-zellij-vim = {
      url = "github:fresh2dev/zellij.vim";
      flake = false;
    };
  };

  nawa.apps._.neovim = {
    homeManager =
      { config, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;

        homeDirectory = config.home.homeDirectory;
        nvimConfig = "${homeDirectory}/majarra/config/nvim";
      in
      {
        imports = [ inputs.wrappers.homeModules.neovim ];
        wrappers.neovim = {
          enable = true;
          imports = [ (import ./_nix inputs) ];
        };
        xdg.configFile = {
          "nvim" = {
            source = mkOutOfStoreSymlink nvimConfig;
            recursive = true;
          };
        };
      };
  };
}
