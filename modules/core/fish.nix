{ nawa, den, ... }:
{
  nawa.core.includes = [ nawa.core._.fish ];

  nawa.core._.fish.includes = [ (den._.user-shell "fish") ];

  nawa.core._.fish = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs.fishPlugins; [
          colored-man-pages
          done
          fish-you-should-use
          pkgs.libnotify
        ];
        programs.fish = {
          enable = true;
          interactiveShellInit = "
            set fish_greeting
            set -g fish_key_bindings fish_vi_key_bindings
            ";
        };
      };
  };
}
