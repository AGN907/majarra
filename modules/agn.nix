{
  den,
  __findFile,
  ...
}:
{
  den.aspects.agn = {
    includes = [
      <den/primary-user>

      <nawa/core>
      <nawa/secrets>

      <nawa/apps/zen>
      <nawa/apps/kitty>
      <nawa/apps/cliTools>
      <nawa/apps/niri>
      <nawa/apps/neovim>
      <nawa/apps/starship>
      <nawa/apps/yazi>
      <nawa/apps/zellij>

      <nawa/services/syncthing/client>
    ];
  };
}
