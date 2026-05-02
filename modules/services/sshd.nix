{
  nawa.ssh.provides = {
    server.nixos =
      { ... }:
      {
        services.openssh = {
          enable = true;
          openFirewall = true;
        };
        users.users = {
          agn.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHOihhPJKc9FqjYxZfodSymca3sWBbDR6PNZo6F45PSw @alioth"
          ];
        };
      };
  };
}
