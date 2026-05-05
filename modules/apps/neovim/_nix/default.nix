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
  config.settings.aliases = [
    "vi"
    "vim"
  ];

  config.settings.colorscheme = "kanso-zen";
}
