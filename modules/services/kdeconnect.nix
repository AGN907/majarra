{
  nawa.services._.kdeconnect = {
    nixos =
      { pkgs, ... }:
      {
        programs.kdeconnect = {
          enable = true;
          package = pkgs.valent;
        };
      };
  };
}
