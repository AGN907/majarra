{
  den,
  __findFile,
  ...
}:
{
  den.aspects.agn = {
    includes = [
      <den/primary-user>
      
      <nawa/secrets>
      <nawa/apps/neovim>
      <nawa/apps/yazi>
      <nawa/apps/zellij>
    ];
  };
}
