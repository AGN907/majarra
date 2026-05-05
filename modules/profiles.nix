{ den, __findFile, ... }:
{
  nawa = {
    workstation.includes = [
      <nawa/core>
      <nawa/services/audio>
      <nawa/services/printing>
      <nawa/services/kanata>
      <nawa/services/network>
    ];

    desktop.includes = [
      <nawa/services/kdeconnect>
      <nawa/services/syncthing/client>
      <nawa/services/sshd/service>
      <nawa/apps/zen>
      <nawa/apps/cliTools>
      <nawa/apps/wezterm>
      <nawa/apps/niri>
      <nawa/workstation>
    ];
  };
}
