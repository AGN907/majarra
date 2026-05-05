{ den, __findFile, ... }:
{
  nawa = {
    workstation.includes = [
      <nawa/core>
      <nawa/services/audio>
      <nawa/services/printing>
      <nawa/services/kanata>
      <nawa/services/networking>
    ];

    desktop.includes = [
      <nawa/services/kdeconnect>
      <nawa/services/syncthing/client>
      <nawa/services/ssh/server>
      <nawa/apps/zen>
      <nawa/apps/cliTools>
      <nawa/apps/wezterm>
      <nawa/apps/niri>
      <nawa/workstation>
    ];
  };
}
