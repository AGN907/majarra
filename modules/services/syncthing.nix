{
  nawa.services._.syncthing = {
    provides.client = {
      # Don't create default ~/Sync folder.  See https://wiki.nixos.org/wiki/Syncthing
      nixos.systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
      homeManager =
        { host, config, ... }:
        let
          syncthingCertSecret = "syncthing/${host.hostName}/cert.pem";
          syncthingKeySecret = "syncthing/${host.hostName}/key.pem";
        in
        {
          sops.secrets.${syncthingCertSecret} = { };
          sops.secrets.${syncthingKeySecret} = { };

          services.syncthing = {
            enable = true;
            overrideDevices = true;
            overrideFolders = true;
            cert = config.sops.secrets.${syncthingCertSecret}.path;
            key = config.sops.secrets.${syncthingKeySecret}.path;
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
