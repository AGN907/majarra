{
  inputs,
  ...
}:
{
  flake-file.inputs.noctalia = {
    url = "github:noctalia-dev/noctalia-shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nawa.apps._.noctalia = {
    nixos.nix.settings = {
      substituters = [ "https://noctalia.cachix.org" ];
      trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
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
                keybind = "1";
              }
              {
                action = "suspend";
                enabled = true;
                keybind = "2";
              }
              {
                action = "reboot";
                enabled = true;
                keybind = "3";
              }
              {
                action = "logout";
                enabled = true;
                keybind = "4";
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
