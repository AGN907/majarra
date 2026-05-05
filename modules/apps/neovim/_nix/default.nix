inputs:
{
  wlib,
  ...
}:
{
  imports = [
    wlib.wrapperModules.neovim
    ./nvim-lib.nix
    ./specs.nix
  ];

  config.settings.config_directory = "/home/agn/.config/nvim";
  config.setttings.aliases = [
    "vi"
    "vim"
  ];

  config.settings.colorscheme = "kanso-zen";
}
