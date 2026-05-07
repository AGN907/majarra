{
  inputs,
  ...
}:
{
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia-shell";

  nawa.apps._.noctalia = {
    homeManager = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia-shell = {
        enable = true;
        settings = {
          bar = {
            density = "default";
            position = "top";
            showCapsule = false;
            widgets = {
              left = [
                {
                  id = "ControlCenter";
                  useDistroLogo = false;
                  icon = "layout-grid";
                  enableColorization = true;
                  colorizeSystemIcon = "primary";
                }
                {
                  id = "Clock";
                  customFont = "Maple Mono NF";
                  formatHorizontal = "HH:mm";
                  formatVertical = "HH mm";
                  useCustomFont = true;
                  usePrimaryColor = true;
                }
              ];
              center = [
                {
                  id = "MediaMini";
                }
                {
                  id = "Workspace";
                  hideUnoccupied = false;
                  pillSize = 0.7;
                  labelMode = "none";
                }
                {
                  id = "NotificationHistory";
                }
              ];
              right = [
                {
                  id = "Tray";
                }
                {
                  id = "SystemMonitor";
                  useMonospaceFont = true;
                }
                {
                  id = "Volume";
                }
                {
                  id = "KeyboardLayout";
                  displayMode = "forceOpen";
                }
              ];
            };
          };
          general = {
            radiusRatio = 0.2;
          };
          location = {
            monthBeforeDay = true;
            name = "Dammam, Saudi Arabia";
          };
          appLauncher = {
            enableClipboardHistory = true;
          };
          sessionMenu = {
            largeButtonsStyle = false;
            powerOptions = [
              {
                action = "lock";
                enabled = true;
                keybind = "l";
              }
              {
                action = "suspend";
                enabled = true;
                keybind = "s";
              }
              {
                action = "hibernate";
                enabled = false;
                keybind = "h";
              }
              {
                action = "reboot";
                enabled = true;
                keybind = "r";
              }
              {
                action = "logout";
                enabled = true;
                keybind = "e";
              }
              {
                action = "shutdown";
                enabled = true;
                keybind = "5";
              }
              {
                action = "rebootToUefi";
                enabled = true;
                keybind = "6";
              }
            ];
          };
        };
      };
    };
  };
}
