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
    plugins-zellij-vim = {
      url = "github:fresh2dev/zellij.vim";
      flake = false;
    };
    plugins-tiny-code-action = {
      url = "github:rachartier/tiny-code-action.nvim";
      flake = false;
    };
  };

  nawa.apps._.neovim = {
    nixos = {
      environment.variables.EDITOR = "vim";
    };
    homeManager =
      { config, lib, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;

        homeDirectory = config.home.homeDirectory;
        nvimConfig = "${homeDirectory}/majarra/config/neovim";
      in
      {
        imports = [ inputs.wrappers.homeModules.neovim ];
        wrappers.neovim = {
          enable = true;
          imports = [ (import ./_nix inputs) ];
          _module.args.stylixColors =
            let
              raw = config.lib.stylix.colors.withHashtag or { };
            in
            lib.filterAttrs (_: v: builtins.isString v) raw;
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
