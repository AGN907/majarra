{ inputs, ... }:
{
  flake-file.inputs = {
    zjstatus.url = "github:dj95/zjstatus";
  };

  nawa.apps._.zellij = {
    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      let
        inherit (pkgs.stdenv.hostPlatform) system;
        inherit (config.lib.file) mkOutOfStoreSymlink;
        inherit (config.home) homeDirectory;
        inherit (config.lib.stylix) colors;

        sesh = pkgs.writeScriptBin "sesh" ''
          #! /usr/bin/env sh

          # select a directory using zoxide
          ZOXIDE_RESULT=$(zoxide query --interactive)
          # checks whether a directory has been selected
          if [[ -z "$ZOXIDE_RESULT" ]]; then
            # if there was no directory, select returns without executing
            exit 0
          fi
          # extracts the directory name from the absolute path
          SESSION_TITLE=$(echo "$ZOXIDE_RESULT" | sed 's#.*/##')

          # get the list of sessions
          SESSION_LIST=$(zellij list-sessions -n | awk '{print $1}')

          # checks if SESSION_TITLE is in the session list
          if echo "$SESSION_LIST" | grep -q "^$SESSION_TITLE$"; then
            # if so, attach to existing session
            zellij attach "$SESSION_TITLE"
          else
            # if not, create a new session 
            LAYOUT=$(${lib.getExe pkgs.gum} choose "default" "dev" --header "Choose a layout for new session:")

            if [[ -z "$LAYOUT" ]]; then
              echo "No layout selected, aborting"
              exit 0
            fi

            cd "$ZOXIDE_RESULT"
            zellij --layout "$LAYOUT" attach -c "$SESSION_TITLE"
          fi
        '';

        statusbar = ''
          default_tab_template {
              pane size=2 borderless=true {
                  plugin location="file://${pkgs.zjstatus}/bin/zjstatus.wasm" {
                      format_left   "{mode} #[fg=#${colors.base01}]| #[fg=#${colors.base04}]  {session}"
                      format_center "{tabs}"
                      format_right  "{command_git_branch}"

                      format_space  ""
                      format_hide_on_overlength "true"
                      format_precedence "crl"

                      border_enabled  "true"
                      border_char     "─"
                      border_format   "#[fg=#${colors.base03}]{char}"
                      border_position "bottom"

                      mode_locked        "#[fg=#${colors.base03},bold]LOCKED "
                      mode_normal        "#[fg=#${colors.base0B},bold]NORMAL"
                      mode_resize        "#[fg=#${colors.base08},bold]RESIZE"
                      mode_pane          "#[fg=#${colors.base0D},bold]PANE"
                      mode_rename_pane   "#[fg=#${colors.base0D},bold]RENAME-PANE"
                      mode_tab           "#[fg=#${colors.base0C},bold]TAB"
                      mode_rename_tab    "#[fg=#${colors.base0C},bold]RENAME-TAB"
                      mode_scroll        "#[fg=#${colors.base0A},bold]SCROLL"
                      mode_enter_search  "#[fg=#${colors.base06},bold]ENT-SEARCH"
                      mode_search        "#[fg=#${colors.base06},bold]SEARCHARCH"
                      mode_session       "#[fg=#${colors.base0E},bold]SESSION"
                      mode_move          "#[fg=#${colors.base0F},bold]MOVE"
                      mode_prompt        "#[fg=#${colors.base0D},bold]PROMPT"
                      mode_tmux          "#[fg=#${colors.base09},bold]TMUX"

                      tab_normal              "#[fg=#${colors.base07}] {index}: {name}{fullscreen_indicator}{sync_indicator}{floating_indicator} "
                      tab_active              "#[bg=#${colors.base01},fg=#${colors.base07}] {index}: {name}{fullscreen_indicator}{sync_indicator}{floating_indicator} "

                      tab_fullscreen_indicator " 󰊓"
                      tab_sync_indicator       " "
                      tab_floating_indicator   " 󰉈"

                      tab_separator           "#[fg=#${colors.base01}] | "

                      command_git_branch_command  "git rev-parse --abbrev-ref HEAD"
                      command_git_branch_format  "#[fg=#${colors.base0D}]  {stdout}"
                      command_git_branch_interval "10"
                      command_git_branch_rendermode "static"
                  }
              }
              children
          }
        '';

        layoutDefault = ''
          layout {
              ${statusbar}

              tab {
                  pane
              }
          }
        '';

        layoutDev = ''
          layout {
            tab name="edit" focus=true {
              pane {
                command "nvim"
                args "."
              }
            }

            tab name="run" {
              pane split_direction="vertical" {
                pane {
                  name "main"
                }
              }
            }

            ${statusbar}
          }
        '';
      in
      {
        nixpkgs.overlays = [
          (_final: _prev: {
            zjstatus = inputs.zjstatus.packages.${system}.default;
          })
        ];

        stylix.targets.zellij.enable = true;
        home.packages = [
          sesh
        ];

        xdg.configFile = {
          "zellij/config.kdl".source =
            mkOutOfStoreSymlink "${homeDirectory}/majarra/config/zellij/config.kdl";
          "zellij/layouts/default.kdl".text = layoutDefault;
          "zellij/layouts/dev.kdl".text = layoutDev;
        };

        programs.zellij.enable = true;
      };
  };
}
