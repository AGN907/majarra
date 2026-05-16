{
  config,
  pkgs,
  stylixColors ? { },
  ...
}:
{

  config.info = {
    colorscheme = "stylix";
    colors = stylixColors;
    nixd = rec {
      flake = "builtins.getFlake (toString /home/agn/majarra)";
      nixpkgs = "import (${flake}).inputs.nixpkgs { }";
      nixos = "(${flake}).nixosConfigurations.alkaid.options";
      homeManager = "(${flake}).nixosConfigurations.alkaid.options.home-manager.users.type.getSubOptions []";
    };
  };

  # {{{ Plugin Manager
  config.specs.lze = [
    config.nvim-lib.neovimPlugins.lze
    {
      data = config.nvim-lib.neovimPlugins.lzextras;
      name = "lzextras";
    }
  ];
  # }}}

  # {{{ LSP, Linting, and Formatting
  config.specs.lsp = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      nvim-lspconfig
      blink-cmp
      colorful-menu-nvim
    ];
  };

  config.specs.treesitter = {
    extraPackages = [ pkgs.tree-sitter ];
    data = with pkgs.vimPlugins; [
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

  config.specs.lint = {
    data = with pkgs.vimPlugins; [
      nvim-lint
      tiny-inline-diagnostic-nvim
    ];
  };

  config.specs.format = pkgs.vimPlugins.conform-nvim;
  # }}}

  # {{{ Mini
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
  # }}}

  # {{{ Language Support
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
  # }}}

  # {{{ Utils
  config.specs.utils = {
    extraPackages = with pkgs; [
      lazygit
    ];
    data = with pkgs.vimPlugins; [
      snacks-nvim
      which-key-nvim
      {
        name = "zellij-vim";
        data = config.nvim-lib.neovimPlugins.zellij-vim;
      }
    ];
  };
  # }}}

}

# vim: foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
