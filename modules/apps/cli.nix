{ nawa, ... }:
{
  nawa.apps._.cli.provides = {
    full.includes = with nawa.apps._.cli._; [
      base
      atuin
      bottom
      rbw
    ];
    base.homeManager =
      { pkgs, ... }:
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
          dysk
          dust
          devenv
          imv
          hl-log-viewer
          just
        ];

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
            config = {
              color = "always";
            };
            extraPackages = with pkgs.bat-extras; [
              batdiff
              batgrep
              prettybat
            ];
          };
          direnv = {
            enable = true;
            nix-direnv.enable = true;
            config.global.warn_timeout = 0;
          };
          tealdeer = {
            enable = true;
            settings.updates.auto_update = true;
          };
        };
      };
    atuin.homeManager =
      { config, ... }:
      {
        sops.secrets.atuin_key = { };

        programs.atuin = {
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
      };
    bottom.homeManager =
      { config, ... }:
      {
        programs.bottom = {
          enable = true;
          settings = {
            process_memory_as_value = true;
            styles = with config.lib.stylix.colors.withHashtag; {
              table.header.colour = base04;
              cpu = {
                all_cpu_colour = base05;
                avg_cpu_colour = base08;

                # CPU Core Palette (Cycle through colourss)
                cpu_core_colours = [
                  base08 # Red
                  base09 # Orange
                  base0A # Yellow
                  base0B # Green
                  base0C # Cyan
                  base0D # Blue
                  base0E # Purple
                  base0F # Brown/Dark Red
                ];
              };
              ram = {
                ram_colour = base0B;
                swap_colour = base09;
                arc_colour = base0C;
                gpu_colours = [
                  base0C
                  base0D
                ];
              };
              widgets = {
                border_colour = base03;
                highlighted_border_colour = base0D;
                text_colour = base05;
                selected_text_colour = base00;
                selected_bg_colour = base0D;
              };
              graphs = {
                graph_colour = base02;
              };
            };
          };
        };
      };
    rbw.homeManager =
      { pkgs, ... }:
      {
        home.sessionVariables = {
          SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
        };

        home.packages = [ pkgs.pinentry-qt ];

        programs.rbw = {
          enable = true;
        };
      };
  };
}
