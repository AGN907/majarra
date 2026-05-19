{ inputs, ... }:
{
  flake-file.inputs = {
    zjstatus.url = "github:dj95/zjstatus";
    zellij-autolock = {
      url = "https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm";
      flake = false;
    };
  };

  nawa.apps._.zellij = {
    homeManager =
      { pkgs, ... }:
      let
        inherit (pkgs.stdenv.hostPlatform) system;

        zjstatusPackage = inputs.zjstatus.packages.${system}.default;

        # Plugins
        zjstatusPath = "file:${pkgs.zjstatus}/bin/zjstatus.wasm";
        zjframesPath = "file:${pkgs.zjstatus}/bin/zjframes.wasm";
        autolockPath = "file:${inputs.zellij-autolock}";
      in
      {
        nixpkgs.overlays = [
          (_final: _prev: {
            zjstatus = zjstatusPackage;
          })
        ];
        programs.zellij = {
          enable = true;
          settings = {
            default_mode = "normal";
            default_shell = "fish";
            default_layout = "default";
            pane_frames = false;

            keybinds = {
              _props.clear-defaults = true;
              _children = [
                {
                  locked._children = [
                    {
                      bind = {
                        _args = [ "Ctrl g" ];
                        SwitchToMode = [ "normal" ];
                      };
                    }
                  ];
                }
                {
                  pane._children = [
                    {
                      bind = {
                        _args = [ "left" ];
                        MoveFocus = [ "left" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "down" ];
                        MoveFocus = [ "down" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "up" ];
                        MoveFocus = [ "up" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "right" ];
                        MoveFocus = [ "right" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "c" ];
                        _children = [
                          { SwitchToMode = [ "renamepane" ]; }
                          { PaneNameInput = [ 0 ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "d" ];
                        _children = [
                          { NewPane = [ "down" ]; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "e" ];
                        _children = [
                          { TogglePaneEmbedOrFloating = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "f" ];
                        _children = [
                          { ToggleFocusFullscreen = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "h" ];
                        MoveFocus = [ "left" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "i" ];
                        _children = [
                          { TogglePanePinned = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "j" ];
                        MoveFocus = [ "down" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "k" ];
                        MoveFocus = [ "up" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "l" ];
                        MoveFocus = [ "right" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "n" ];
                        _children = [
                          { NewPane = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "p" ];
                        SwitchFocus = { };
                      };
                    }
                    {
                      bind = {
                        _args = [ "Ctrl p" ];
                        SwitchToMode = [ "normal" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "r" ];
                        _children = [
                          { NewPane = [ "right" ]; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "s" ];
                        _children = [
                          { NewPane = [ "stacked" ]; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "w" ];
                        _children = [
                          { ToggleFloatingPanes = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "z" ];
                        _children = [
                          { TogglePaneFrames = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                  ];
                }
                {
                  tab._children = [
                    # Tab navigation and 1-9 binds
                    {
                      bind = {
                        _args = [ "left" ];
                        GoToPreviousTab = { };
                      };
                    }
                    {
                      bind = {
                        _args = [ "down" ];
                        GoToNextTab = { };
                      };
                    }
                    {
                      bind = {
                        _args = [ "up" ];
                        GoToPreviousTab = { };
                      };
                    }
                    {
                      bind = {
                        _args = [ "right" ];
                        GoToNextTab = { };
                      };
                    }
                    # Example for tab 1
                    {
                      bind = {
                        _args = [ "1" ];
                        _children = [
                          { GoToTab = [ 1 ]; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    # ... Repeat pattern for 2-9 ...
                    {
                      bind = {
                        _args = [ "n" ];
                        _children = [
                          { NewTab = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "x" ];
                        _children = [
                          { CloseTab = { }; }
                          { SwitchToMode = [ "normal" ]; }
                        ];
                      };
                    }
                  ];
                }
                {
                  "shared_except"._args = [ "locked" ];
                  "shared_except"._children = [
                    {
                      bind = {
                        _args = [ "Ctrl q" ];
                        Quit = { };
                      };
                    }
                    {
                      bind = {
                        _args = [ "Ctrl h" ];
                        MoveFocusOrTab = [ "Left" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "Ctrl l" ];
                        MoveFocusOrTab = [ "Right" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "Ctrl j" ];
                        MoveFocus = [ "Down" ];
                      };
                    }
                    {
                      bind = {
                        _args = [ "Ctrl k" ];
                        MoveFocus = [ "Up" ];
                      };
                    }
                  ];
                }
              ];
            };

            plugins = {
              autolock = {
                _props.location = autolockPath;
                _children = [
                  { is_enabled = true; }
                  { reaction_seconds = "0.3"; }
                  { triggers = "nvim|vim|git|fzf|zoxide|atuin|lazygit|lazysql"; }
                ];
              };
              zjstatus = {
                _props.location = zjstatusPath;
                _children = [
                  { format_left = "{mode} #[bg=#090E13,fg=#C5C9C7,bold] {session}"; }
                  { format_center = "{tabs}"; }
                  { format_right = "{datetime}"; }
                  { format_space = "#[bg=#090E13]"; }
                  { border_enabled = "true"; }
                  { border_char = "─"; }
                  { border_format = "#[fg=#C5C9C7]{char}"; }
                  { mode_normal = "#[bg=#8A9A7B,fg=#090E13,bold] NORMAL #[bg=black,fg=blue]"; }
                  { mode_locked = "#[bg=#C4746E,fg=#090E13,bold] LOCKED #[bg=black,fg=red]"; }
                  { datetime_format = "%A, %d %b %Y %H:%M"; }
                  { datetime_timezone = "Asia/Riyadh"; }
                ];
              };
              zjframes = {
                _props.location = zjframesPath;
                _children = [
                  { hide_frame_except_for_search = "true"; }
                  { hide_frame_except_for_scroll = "true"; }
                  { hide_frame_except_for_fullscreen = "true"; }
                ];
              };
            };

            load_plugins = {
              _children = [
                { autolock = { }; }
                { zjframes = { }; }
              ];
            };
          };
          layouts = {
            default = {
              layout = {
                _children = [
                  {
                    swap_tiled_layout = {
                      _props.name = "vertical";
                      _children = [
                        {
                          tab = {
                            _props.max_panes = 5;
                            _children = [
                              {
                                pane = {
                                  _props.split_direction = "vertical";
                                  _children = [
                                    { pane = { }; }
                                    {
                                      pane = {
                                        _children = [ { children = { }; } ];
                                      };
                                    }
                                  ];
                                };
                              }
                            ];
                          };
                        }
                        {
                          tab = {
                            _props.max_panes = 8;
                            _children = [
                              {
                                pane = {
                                  _props.split_direction = "vertical";
                                  _children = [
                                    {
                                      pane = {
                                        _children = [ { children = { }; } ];
                                      };
                                    }
                                    {
                                      pane = {
                                        _children = [
                                          { pane = { }; }
                                          { pane = { }; }
                                          { pane = { }; }
                                          { pane = { }; }
                                        ];
                                      };
                                    }
                                  ];
                                };
                              }
                            ];
                          };
                        }
                        {
                          tab = {
                            _props.max_panes = 12;
                            _children = [
                              {
                                pane = {
                                  _props.split_direction = "vertical";
                                  _children = [
                                    {
                                      pane = {
                                        _children = [ { children = { }; } ];
                                      };
                                    }
                                    {
                                      pane = {
                                        _children = [
                                          { pane = { }; }
                                          { pane = { }; }
                                          { pane = { }; }
                                          { pane = { }; }
                                        ];
                                      };
                                    }
                                    {
                                      pane = {
                                        _children = [
                                          { pane = { }; }
                                          { pane = { }; }
                                          { pane = { }; }
                                          { pane = { }; }
                                        ];
                                      };
                                    }
                                  ];
                                };
                              }
                            ];
                          };
                        }
                      ];
                    };
                  }
                  {
                    default_tab_template = {
                      _children = [
                        {
                          pane = {
                            _props = {
                              size = 1;
                              borderless = true;
                            };
                            _children = [
                              {
                                plugin = {
                                  _props.location = "zjstatus";
                                };
                              }
                            ];
                          };
                        }
                        { children = { }; }
                        {
                          pane = {
                            _props = {
                              size = 1;
                              borderless = true;
                            };
                            _children = [
                              {
                                plugin = {
                                  _props.location = "zellij:status-bar";
                                };
                              }
                            ];
                          };
                        }
                      ];
                    };
                  }
                ];
              };
            };
          };
        };
      };
  };
}
