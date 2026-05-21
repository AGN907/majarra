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
    svelteTypescriptPlugin = "${pkgs.svelte-language-server}/node_modules/typescript-svelte-plugin";
  };

  config.specs.general = {
    data = with pkgs.vimPlugins; [
      config.nvim-lib.neovimPlugins.lze
      mini-base16
      mini-basics
      mini-comment
      mini-extra
      mini-notify
      mini-icons
      mini-misc
      snacks-nvim
      which-key-nvim
      quicker-nvim
      {
        data = config.nvim-lib.neovimPlugins.lzextras;
        name = "lzextras";
      }
    ];
  };

  config.specs.lsp = {
    lazy = true;
    data = pkgs.vimPlugins.nvim-lspconfig;
  };

  config.specs.cmp = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      blink-cmp
      colorful-menu-nvim
      mini-snippets
      friendly-snippets
    ];
  };

  config.specs.lint = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      nvim-lint
    ];
  };

  config.specs.format = {
    lazy = true;
    data = pkgs.vimPlugins.conform-nvim;
  };

  config.specs.treesitter = {
    data = null;
    extraPackages = [ pkgs.tree-sitter ];
  };

  config.specs.editor = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      mini-bufremove
      mini-files
      mini-sessions
      mini-pick
      mini-tabline
      tiny-inline-diagnostic-nvim
    ];
  };

  config.specs.coding = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      mini-ai
      mini-align
      mini-bracketed
      mini-jump
      mini-operators
      mini-splitjoin
      mini-surround
      mini-move
    ];
  };

  config.specs.ui = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      mini-animate
      mini-hipatterns
      mini-indentscope
    ];
  };

  config.specs.git = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      mini-git
      mini-diff
    ];
    extraPackages = [
      pkgs.lazygit
    ];
  };

  # Languages Support
  config.specs.nix = {
    data = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [
        p.nix
      ]))
    ];
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
  };
  config.specs.lua = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      lazydev-nvim
      (nvim-treesitter.withPlugins (p: [
        p.lua
      ]))
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
    ];
  };
  config.specs.typescript = {
    lazy = false;
    data = null;
    extraPackages = with pkgs; [
      vtsls
      biome
      svelte-language-server
    ];
  };

  config.specs.utils = {
    data = [
      {
        name = "zellij-vim";
        data = config.nvim-lib.neovimPlugins.zellij-vim;
      }
    ];
  };

}
