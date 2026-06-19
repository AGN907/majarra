{ self, inputs, ... }:
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
      {
        system,
        ...
      }:
      {
        home.packages = [
          self.packages.${system}.nvim
        ];
      };
  };

  den.aspects.flake.packages = { pkgs, lib, ... }: {
    nvim = (
      inputs.wrappers.lib.evalPackage {
        inherit pkgs;
        imports = [
          inputs.wrappers.wrapperModules.neovim
          (import ./_nix inputs)
        ];
        _module.args.stylixColors =
          let
            raw = self.nixosConfigurations.alkaid.config.lib.stylix.colors.withHashtag or { };
          in
          lib.filterAttrs (_: v: builtins.isString v) raw;
      }
    );
  };
}
