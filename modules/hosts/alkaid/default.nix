{
  den.hosts.x86_64-linux.alkaid = {
    users.agn.classes = [ "homeManager" ];
  };
  den.aspects.alkaid = {
    nixos = {
      hardware.facter.reportPath = ./facter.json;
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
    provides.to-users = {
      nixos = {
        environment.pathsToLink = [
          "/share/applications"
          "/share/xdg-desktop-portal"
        ];
      };
      homeManager = {
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
            desktop = null;
            templates = null;
            publicShare = null;
          };
        };
      };
    };
  };
}
