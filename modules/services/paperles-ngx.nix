{
  nawa.services._.paperless-ngx = {
    nixos =
      { config, ... }:
      {
        sops.secrets."paperless/admin_password" = {
          owner = "paperless";
        };
        sops.secrets."restic/paperless" = { };
        sops.secrets.rclone = { };

        systemd.services.paperless-exporter.postStart = ''
          echo "Paperless export finished. Triggering Restic backup..."
          systemctl start restic-backups-paperless-gdrive.service
        '';

        services.restic.backups.paperless-ngx = {
          initialize = true;

          repository = "rclone:gdrive:paperless-backups";

          passwordFile = config.sops.secrets."restic/paperless".path;
          rcloneConfigFile = config.sops.secrets.rclone.path;

          paths = [ config.services.paperless.exporter.directory ];

          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 4"
            "--keep-monthly 12"
          ];
        };

        services.paperless = {
          enable = true;
          passwordFile = config.sops.secrets."paperless/admin_password".path;
          consumptionDirIsPublic = true;
          exporter = {
            enable = true;
            onCalendar = "20:30:00";
            settings = {
              compare-checksums = true;
              delete = true;
              use-filename-format = true;
              no-progress-bar = true;
              no-archive = true;
              no-thumbnail = true;
            };
          };
          settings = {
            PAPERLESS_ADMIN_USER = "agn";
            PAPERLESS_TIME_ZONE = "Asia/Riyadh";
            PAPERLESS_OCR_LANGUAGE = "ara+eng";
            PAPERLESS_CONSUMER_RECURSIVE = true;
            PAPERLESS_CONSUMER_IGNORE_PATTERN = [
              ".DS_STORE/*"
              "desktop.ini"
              "Thumbs.db"
            ];
            PAPERLESS_FILENAME_FORMAT = "{{ created_year }}/{{ correspondent }}/{{ title }}";
          };
        };

      };
  };
}
