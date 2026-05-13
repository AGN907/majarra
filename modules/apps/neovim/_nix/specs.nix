{
  config,
  wlib,
  lib,
  pkgs,
  stylixColors ? { },
  ...
}:
{

  config.info = {
    colorscheme = "stylix";
    colors = stylixColors;
  };

  config.specs.lze = [
    config.nvim-lib.neovimPlugins.lze
    {
      data = config.nvim-lib.neovimPlugins.lzextras;
      name = "lzextras";
    }
  ];

  config.specs.nix = {
    data = null;
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
  };
  config.specs.lua = {
    after = [ "general" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      lazydev-nvim
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
    ];
  };

  config.specs.general = {
    after = [ "lze" ];
    extraPackages = with pkgs; [
      lazygit
      tree-sitter
    ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      nvim-lspconfig
      blink-cmp
      colorful-menu-nvim
      which-key-nvim
      nvim-lint
      conform-nvim
      {
        name = "zellij-vim";
        data = config.nvim-lib.neovimPlugins.zellij-vim;
      }
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          nix
          lua
          yaml
          markdown
          json
          go
          gosum
          gomod
          rust
          php
          php_only
          blade
          just
        ]
      ))
    ];
  };

  config.specs.mini = {
    before = [ "general" ];
    data = with pkgs.vimPlugins; [
      mini-ai
      mini-align
      mini-animate
      mini-basics
      mini-base16
      mini-bracketed
      mini-bufremove
      mini-comment
      mini-diff
      mini-extra
      mini-files
      mini-git
      mini-hipatterns
      mini-icons
      mini-indentscope
      mini-jump
      mini-misc
      mini-move
      mini-notify
      mini-operators
      mini-pick
      mini-sessions
      mini-snippets
      mini-splitjoin
      mini-surround
      mini-tabline
    ];
  };

  # This submodule modifies both levels of your specs
  config.specMods =
    {
      # When this module is ran in an inner list,
      # this will contain `config` of the parent spec
      # and this will contain `options`
      # otherwise they will be `null`
      # and then config from this one, as normal
      # and the other module arguments.
      ...
    }:
    {
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
        description = "a extraPackages spec field to put packages to suffix to the PATH";
      };
    };
  config.extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];
}
