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
              pane size=1 borderless=true {
                  plugin location="file://${pkgs.zjstatus}/bin/zjstatus.wasm" {
                      format_left   "{mode}#[bg=#${colors.base00}] {tabs}"
                      format_center ""
                      format_right  "#[bg=#${colors.base00},fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base01},bold] #[bg=#${colors.base02},fg=#${colors.base05},bold] {session} #[bg=#${colors.base03},fg=#${colors.base05},bold]"
                      format_space  ""
                      format_hide_on_overlength "true"
                      format_precedence "crl"

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=#6C7086]{char}"
                      border_position "top"

                      mode_normal        "#[bg=#${colors.base0B},fg=#${colors.base02},bold] NORMAL#[bg=#${colors.base03},fg=#${colors.base0B}]█"
                      mode_locked        "#[bg=#${colors.base04},fg=#${colors.base02},bold] LOCKED #[bg=#${colors.base03},fg=#${colors.base04}]█"
                      mode_resize        "#[bg=#${colors.base08},fg=#${colors.base02},bold] RESIZE#[bg=#${colors.base03},fg=#${colors.base08}]█"
                      mode_pane          "#[bg=#${colors.base0D},fg=#${colors.base02},bold] PANE#[bg=#${colors.base03},fg=#${colors.base0D}]█"
                      mode_tab           "#[bg=#${colors.base07},fg=#${colors.base02},bold] TAB#[bg=#${colors.base03},fg=#${colors.base07}]█"
                      mode_scroll        "#[bg=#${colors.base0A},fg=#${colors.base02},bold] SCROLL#[bg=#${colors.base03},fg=#${colors.base0A}]█"
                      mode_enter_search  "#[bg=#${colors.base0D},fg=#${colors.base02},bold] ENT-SEARCH#[bg=#${colors.base03},fg=#${colors.base0D}]█"
                      mode_search        "#[bg=#${colors.base0D},fg=#${colors.base02},bold] SEARCHARCH#[bg=#${colors.base03},fg=#${colors.base0D}]█"
                      mode_rename_tab    "#[bg=#${colors.base07},fg=#${colors.base02},bold] RENAME-TAB#[bg=#${colors.base03},fg=#${colors.base07}]█"
                      mode_rename_pane   "#[bg=#${colors.base0D},fg=#${colors.base02},bold] RENAME-PANE#[bg=#${colors.base03},fg=#${colors.base0D}]█"
                      mode_session       "#[bg=#${colors.base0E},fg=#${colors.base02},bold] SESSION#[bg=#${colors.base03},fg=#${colors.base0E}]█"
                      mode_move          "#[bg=#${colors.base0F},fg=#${colors.base02},bold] MOVE#[bg=#${colors.base03},fg=#${colors.base0F}]█"
                      mode_prompt        "#[bg=#${colors.base0D},fg=#${colors.base02},bold] PROMPT#[bg=#${colors.base03},fg=#${colors.base0D}]█"
                      mode_tmux          "#[bg=#${colors.base09},fg=#${colors.base02},bold] TMUX#[bg=#${colors.base03},fg=#${colors.base09}]█"

                      tab_normal              "#[bg=#${colors.base03},fg=#${colors.base0D}]█#[bg=#${colors.base0D},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{floating_indicator}#[bg=#${colors.base03},fg=#${colors.base02},bold]█"
                      tab_normal_fullscreen   "#[bg=#${colors.base03},fg=#${colors.base0D}]█#[bg=#${colors.base0D},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{fullscreen_indicator}#[bg=#${colors.base03},fg=#${colors.base02},bold]█"
                      tab_normal_sync         "#[bg=#${colors.base03},fg=#${colors.base0D}]█#[bg=#${colors.base0D},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{sync_indicator}#[bg=#${colors.base03},fg=#${colors.base02},bold]█"

                      tab_active              "#[bg=#${colors.base03},fg=#${colors.base09}]█#[bg=#${colors.base09},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{floating_indicator}#[bg=#${colors.base03},fg=#${colors.base02},bold]█"
                      tab_active_fullscreen   "#[bg=#${colors.base03},fg=#${colors.base09}]█#[bg=#${colors.base09},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{fullscreen_indicator}#[bg=#${colors.base03},fg=#${colors.base02},bold]█"
                      tab_active_sync         "#[bg=#${colors.base03},fg=#${colors.base09}]█#[bg=#${colors.base09},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{sync_indicator}#[bg=#${colors.base03},fg=#${colors.base02},bold]█"

                      tab_separator           "#[bg=#${colors.base00}] "

                      tab_sync_indicator       " "
                      tab_fullscreen_indicator " 󰊓"
                      tab_floating_indicator   " 󰹙"

                      command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                      command_git_branch_format      "#[fg=blue] {stdout} "
                      command_git_branch_interval    "10"
                      command_git_branch_rendermode  "static"
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
            tab name="code" focus=true {
              pane {
                command "nvim"
                args "."
              }
            }

            tab name="exec" {
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
