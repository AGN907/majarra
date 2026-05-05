{ lib, den, ... }:
{
  den.default = {
    includes = [
      den._.define-user
      den._.hostname
    ];
    nixos = {
      system.stateVersion = "25.11";
      time.timeZone = lib.mkDefault "Asia/Riyadh";
      i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
    };
    homeManager.home.stateVersion = "25.11";
  };

  den.ctx.user.includes = [ den._.mutual-provider ];
  _module.args.__findFile = den.lib.__findFile;
}
