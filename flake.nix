# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    den.url = "github:vic/den";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    import-tree.url = "github:vic/import-tree";
    kdeconnect-yazi = {
      flake = false;
      url = "github:Deepak22903/kdeconnect-send.yazi";
    };
    niri.url = "github:sodiboo/niri-flake";
    nix-auto-follow = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:fzakaria/nix-auto-follow";
    };
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    nixpkgs-lib.follows = "nixpkgs";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    plugins-kanso = {
      flake = false;
      url = "github:webhooked/kanso.nvim";
    };
    plugins-lze = {
      flake = false;
      url = "github:BirdeeHub/lze";
    };
    plugins-lzextras = {
      flake = false;
      url = "github:BirdeeHub/lzextras";
    };
    plugins-zellij-vim = {
      flake = false;
      url = "github:fresh2dev/zellij.vim";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions.url = "github:vicinaehq/extensions";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    yazi.url = "github:sxyazi/yazi";
    zellij-autolock = {
      flake = false;
      url = "https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    zjstatus.url = "github:dj95/zjstatus";
  };

}
