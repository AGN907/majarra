{ lib, nawa, ... }:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (lib.splitString " " cmd);
  vicinae = cmd: [ "vicinae" ] ++ (lib.splitString " " cmd);
in
{
  nawa.apps._.niri.includes = [
    nawa.apps._.niri._.keymaps
  ];

  nawa.apps._.niri._.keymaps = {
    homeManager = {
      programs.niri.settings.binds = {
        "Mod+Space".action.spawn = vicinae "toggle";
        "Mod+V".action.spawn = vicinae "vicinae://launch/clipboard/history";
        "Mod+Return".action.spawn = [
          "wezterm"
        ];
        "Mod+B".action.spawn = [
          "zen-beta"
        ];
        "Mod+S".action.spawn = noctalia "settings toggle";
        "Mod+Comma".action.spawn = noctalia "controlCenter toggle";
        "Mod+M".action.spawn = noctalia "systemMonitor toggle";
        "Mod+P".action.spawn = noctalia "sessionMenu toggle";
        "Mod+Alt+L".action.spawn = noctalia "lockScreen lock";
        "Mod+Alt+S".action.spawn = noctalia "sessionMenu lockAndSuspend";
        "Mod+Q".action.close-window = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+Shift+T".action.toggle-window-floating = { };
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = { };
        "Mod+Shift+E".action.quit.skip-confirmation = true;
        "Print".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };
        # Focus Navigation
        "Mod+H".action.focus-column-left = { };
        "Mod+J".action.focus-window-or-workspace-down = { };
        "Mod+K".action.focus-window-or-workspace-up = { };
        "Mod+L".action.focus-column-right = { };
        # Window Movement
        "Mod+Shift+H".action.move-column-left = { };
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = { };
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = { };
        "Mod+Shift+L".action.move-column-right = { };
        # Workspace Navigation
        "Mod+U".action.focus-workspace-down = { };
        "Mod+I".action.focus-workspace-up = { };
        # Numeric Workspace Navigation
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        # Column Management
        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };
        # Sizing & Layout
        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.switch-preset-window-height = { };
        "Mod+Ctrl+R".action.reset-window-height = { };
        "Mod+Minus".action.set-window-width = "-10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Equal".action.set-window-width = "+10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";
      };
    };
  };
}
