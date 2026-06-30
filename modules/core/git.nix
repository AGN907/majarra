{ nawa, ... }:

{
  nawa.core.includes = [ nawa.core._.git ];

  nawa.core._.git.homeManager =
    { config, ... }:
    {
      sops.secrets.git = { };

      stylix.targets.lazygit.enable = true;

      programs = {
        git = {
          enable = true;
          includes = [
            { inherit (config.sops.secrets.git) path; }
          ];
          signing = {
            format = "ssh";
            signByDefault = true;
          };
          settings = {
            init.defaultBranch = "main";
            pull.rebase = true;
          };
        };
        delta = {
          enable = true;
          enableGitIntegration = true;
        };
        difftastic = {
          enable = true;
        };
        lazygit = {
          enable = true;
          settings = {
            git = {
              pagers = [
                {
                  pager = "delta --dark --paging=never";
                }
                {
                  externalDiffCommand = "difft --color=always";
                }
              ];
            };
          };
        };
      };
    };
}
