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
  };
}
