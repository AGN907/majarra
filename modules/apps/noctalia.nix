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
    homeManager =
      { lib, ... }:
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];
        programs.noctalia-shell = {
          enable = true;
          settings = {
            general = {
              language = "en-GB";
              radiusRatio = 0.3;
              enableBlurBehind = true;
              enableShadows = true;
              telemetryEnabled = false;
              # Lock settings
              compactLockScreen = true;
              lockScreenBlur = 0.75;
              lockScreenTint = 0.1;
              lockScreenCountdownDuration = 3000;
              lockOnSuspend = true;
              showHibernateOnLockScreen = false;
              showSessionButtonsOnLockScreen = true;
            };
            ui = {
              panelAttachedToBar = true;
              settingsPanelMode = "attached";
              panelBackgroundOpacity = lib.mkForce 0.60;
              translucentWidgets = true;
            };
            bar = {
              density = "default";
              position = "top";
              barType = "floating";
              frameThickness = 4;
              useSeparateOpacity = true;
              backgroundOpacity = lib.mkForce 0.5;
              showCapsule = true;
              capsuleOpacity = lib.mkForce 0.45;
              mouseWheelAction = "workspace";
              reverseScroll = true;
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
                    id = "Workspace";
                    hideUnoccupied = false;
                    enableScrollWheel = true;
                    pillSize = 0.6;
                    labelMode = "none";
                  }
                  {
                    id = "SystemMonitor";
                    compactMode = true;
                    useMonospaceFont = true;
                    showCpuUsage = true;
                    showCpuTemp = true;
                    showMemoryUsage = true;
                  }
                  {
                    id = "ActiveWindow";
                    hideMode = "hidden";
                    maxWidth = 175;
                    showText = true;
                    showIcon = true;
                    scrollingMode = "hover";
                  }
                ];
                center = [
                  {
                    id = "Clock";
                    formatHorizontal = "h:mm AP - ddd - MMM d";
                    formatVertical = "HH mm";
                    tooltipFormat = "HH:mm ddd, MMM dd yyyy";
                    useCustomFont = false;
                    usePrimaryColor = true;
                  }

                ];
                right = [
                  {
                    id = "MediaMini";
                  }
                  {
                    id = "Tray";
                  }
                  {
                    id = "NotificationHistory";
                    showUnreadBadge = true;
                    hideWhenZero = false;
                  }
                  {
                    id = "Volume";
                  }
                  {
                    id = "KeyboardLayout";
                    displayMode = "onhover";
                    showIcon = true;
                  }
                  {
                    id = "SessionMenu";
                    iconColor = "error";
                  }
                ];
              };
            };
            dock = {
              enabled = false;
            };
            notifications = {
              enabled = true;
              density = "default";
              location = "top_right";
              enableMediaToast = true;
              enableBatteryToast = true;
              enableKeyboardLayoutToast = true;
              clearDismissed = true;
              backgroundOpacity = lib.mkForce 0.6;
            };
            osd = {
              enabled = true;
              autoHideMs = 2000;
              enabledTypes = [
                0
                1
                2
              ];
              backgroundOpacity = lib.mkForce 0.6;
            };
            sessionMenu = {
              largeButtonsStyle = false;
              position = "bottom_right";
              showKeybinds = true;
              enableCountdown = true;
              countdownDuration = 3000;
              powerOptions = [
                {
                  action = "lock";
                  enabled = true;
                  countdownEnabled = false;
                  keybind = "L";
                }
                {
                  action = "suspend";
                  enabled = true;
                  countdownEnabled = false;
                  keybind = "S";
                }
                {
                  action = "reboot";
                  enabled = true;
                  keybind = "R";
                }
                {
                  action = "logout";
                  enabled = true;
                  countdownEnabled = false;
                  keybind = "e";
                }
                {
                  action = "shutdown";
                  enabled = true;
                  keybind = "D";
                }
                {
                  action = "rebootToUefi";
                  enabled = true;
                  keybind = "Shift+R";
                }
                {
                  action = "hibernate";
                  enabled = false;
                }
              ];
            };
            idle = {
              enabled = true;
              screenOffTimeout = 1000;
              lockTimeout = 1050;
              suspendTimout = 3600;
            };
            location = {
              weatherEnabled = true;
              monthBeforeDay = true;
              name = "Dammam, Saudi Arabia";
              firstDayOfWeek = 6;
              hideWeatherCityName = false;
              hideWeatherTimezone = true;
            };
            appLauncher = {
              enableClipboardHistory = true;
            };
          };
        };
      };
  };
}
