inputs:
{
  wlib,
  ...
}:
{
  _file = ./default.nix;
  key = ./default.nix;
  config._module.args.inputs = inputs;

  imports = [
    wlib.wrapperModules.neovim
    ./nvim-lib.nix
    ./specs.nix
  ];

  config.settings.config_directory = "/home/agn/majarra/config/neovim";
  config.settings.aliases = [
    "vi"
    "vim"
  ];

  config.hosts = {
    node.nvim-host.enable = false;
    python3.nvim-host.enable = false;
    ruby.nvim-host.enable = false;
  };
}
