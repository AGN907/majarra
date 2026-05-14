{
  nawa.apps._.cliTools = {
    homeManager =
      { pkgs, config, ... }:
      {
        home.packages = with pkgs; [
          aria2
          fd
          jq
          ripgrep
          wget
          imagemagick
          ffmpeg
          age
          xh
          yt-dlp
          pinentry-qt
        ];
        sops.secrets.atuin_key = { };

        programs = {
          zoxide = {
            enable = true;
            enableFishIntegration = true;
          };
          eza = {
            enable = true;
            enableFishIntegration = true;
            git = true;
            colors = "always";
            icons = "always";
          };
          bat = {
            enable = true;
            extraPackages = with pkgs.bat-extras; [
              batdiff
              batgrep
              prettybat
            ];
          };
          atuin = {
            enable = true;
            flags = [ "--disable-up-arrow" ];
            enableFishIntegration = true;
            forceOverwriteSettings = true;
            settings = {
              dialect = "uk";
              sync_address = "https://api.atuin.sh";
              sync_frequency = "2h";
              enter_accept = true;
              key_path = config.sops.secrets.atuin_key.path;
              keymap-mode = "vim-normal";
              show_help = true;
              stats = {
                common_subcommands = [
                  "cargo"
                  "composer"
                  "docker"
                  "git"
                  "npm"
                  "pnpm"
                  "systemctl"
                  "zellij"
                ];
                ignored_commands = [
                  "cd"
                  "z"
                  "ls"
                  "vi"
                ];
              };
              sync.records = true;
              search.filters = [
                "global"
                "host"
                "session"
                "workspace"
                "directory"
              ];
              dotfiles.enabled = true;
            };
          };
          direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
          tealdeer = {
            enable = true;
            settings.updates.auto_update = true;
          };
          rbw = {
            enable = true;
          };
        };
      };
  };
}
