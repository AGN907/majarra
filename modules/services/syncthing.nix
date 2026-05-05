{
  nawa.services._.syncthing = {
    provides.client = {
      # Don't create default ~/Sync folder.  See https://wiki.nixos.org/wiki/Syncthing
      nixos.systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
      homeManager =
        { config, ... }:
        {
          sops.secrets."syncthing/cert.pem" = { };
          sops.secrets."syncthing/key.pem" = { };
          services.syncthing = {
            enable = true;
            overrideDevices = true;
            overrideFolders = true;
            key = config.sops.secrets."syncthing/key.pem".path;
            cert = config.sops.secrets."syncthing/cert.pem".path;
            settings = {
              devices = {
                alioth = {
                  id = "V767LGL-TYBFAHA-GYV3MJ7-KCFWV2F-SJ5DASJ-PZHUCCM-EBQFLER-6V3QKAP";
                  autoAcceptFolders = true;
                };
              };
              folders = {
                "~/Documents/second-brain" = {
                  id = "second-brain";
                  devices = [ "alioth" ];
                };
                "~/Music" = {
                  id = "music";
                  devices = [ "alioth" ];
                };
              };
            };
          };
        };
    };
  };
}
