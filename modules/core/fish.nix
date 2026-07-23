{ nawa, den, ... }:
{
  nawa.core.includes = [ nawa.core._.fish ];

  nawa.core._.fish.includes = [ (den._.user-shell "fish") ];

  nawa.core._.fish = {
    homeManager =
      { pkgs, ... }:
      {
        stylix.targets.fish.enable = true;
        home.packages = with pkgs.fishPlugins; [
          colored-man-pages
          done
          pkgs.libnotify
          fzf-fish
          git-abbr
        ];
        programs.fish = {
          enable = true;
          interactiveShellInit = "
            set fish_greeting
            fish_vi_key_bindings

            devenv hook fish | source
            ";
          shellAbbrs = {
            vim = "nvim";
            cd = "z";
            cdi = "zi";
            cat = "bat";
            ls = "eza";
            la = "eza -a";
            lla = "eza -la";
            tree = "eza --tree";
            rm = "gomi";
            jc = "just --choose";
            tldrf = ''tldr --list | fzf --preview "tldr {1} --color" --preview-window=right,70% | xargs tldr'';
          };
          functions = {
            fish_command_not_found = ''
              if contains $argv[1] $__command_not_found_confirmed_commands
                or ${pkgs.gum}/bin/gum confirm --selected.background=2 "Run using comma?"
                if not contains $argv[1] $__command_not_found_confirmed_commands
                  set -ga __fish_run_with_comma_commands $argv[1]
                end
                comma -- $argv
                return 0
              else
                __fish_default_command_not_found_handler $argv
              end
            '';
          };
        };
      };
  };
}
