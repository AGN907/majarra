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
          shellAliases = {
            # Git
            g = "git";
            ga = "git add";
            gaa = "git add --all";
            gb = "git branch";
            gbd = "git branch --delete";
            gco = "git checkout";
            gcb = "git checkout -b";
            gc = "git commit --verbose";
            gcm = "git commit --verbose --message";
            "gca!" = "git commit --verbose --amend";
            gd = "git diff";
            gdca = "git diff --cached";
            gds = "git diff --staged";
            glgg = "git log --graph";
            glgga = "git log --graph --decorate --all";
            gm = "git merge";
            gma = "git merge --abort";
            gmc = "git merge --continue";
            gms = "git merge --squash";
            gl = "git pull";
            gpr = "git pull --rebase";
            gp = "git push";
            gpd = "git push --dry-run";
            grf = "git reflog";
            gra = "git remote add";
            grh = "git reset";
            gru = "git reset --";
            grhh = "git reset --hard";
            grhs = "git reset --soft";
            grs = "git restore";
            gsh = "git show";
            gs = "git status";

            # Bat
            cat = "bat";

          };
        };
      };
  };
}
