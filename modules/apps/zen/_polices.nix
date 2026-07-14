let
  extensions = import ./_extensions.nix;
in
{
  AllowFileSelectionDialogs = true;
  AppAutoUpdate = false;
  AutofilAddressEnabled = false;
  AutofilCreditCardEnabled = false;
  BackgroundAppUpdate = false;
  BlockAboutAddons = false;
  BlockAboutConfig = false;
  BlockAboutProfiles = false;
  DisableAppUpdate = true;
  DisableFirefoxAccounts = true;
  DisableFirefoxScreenshots = true;
  DisableFormHistory = true;
  DisableTelemetry = true;
  DisablePocket = true;
  DontCheckDefaultBrowser = true;
  NoDefaultBookmarks = true;
  HardwareAcceleration = true;
  ManualAppUpdateOnly = true;
  OfferToSaveLogins = false;
}
// extensions
