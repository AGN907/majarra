{
  nawa.services._.immich = {
    nixos =
      { config, ... }:
      {
        sops.secrets."restic/immich" = { };
        sops.secrets.rclone = { };

        services.restic.backups.immich = {
          initialize = true;

          repository = "rclone:gdrive:immich-backups";

          passwordFile = config.sops.secrets."restic/immich".path;
          rcloneConfigFile = config.sops.secrets.rclone.path;

          paths = [ config.services.immich.mediaLocation ];

          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 4"
            "--keep-monthly 12"
          ];
        };

        services.immich = {
          enable = true;
          host = "0.0.0.0";
          port = 2283;
          openFirewall = true;
        };
      };
  };
}
