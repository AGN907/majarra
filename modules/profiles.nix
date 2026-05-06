{ den, __findFile, ... }:
{
  nawa = {
    workstation.includes = [
      <nawa/services/audio>
      <nawa/services/printing>
      <nawa/services/kanata>
      <nawa/services/networking>
    ];

    desktop.includes = [
      <nawa/services/kdeconnect>
      <nawa/services/ssh/server>
      <nawa/workstation>
    ];
  };
}
