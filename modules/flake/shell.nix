{
  inputs,
  den,
  lib,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default =
        let
          inherit (pkgs.stdenvNoCC.targetPlatform) system;

          denApps = den.lib.nh.denApps {
            outPrefix = [ ];
            fromFlake = true;
          } pkgs;

          formatter = inputs.self.formatter.${system};
          fmtt = pkgs.writeShellApplication {
            name = "fmtt";
            text = ''
              ${lib.getExe formatter} "$@"
            '';
          };
          nix_conf = {
            inherit (inputs.self.nixosConfigurations.alkaid.config.nix.settings)
              experimental-features
              substituters
              trusted-public-keys
              ;
          };

          nix_conf_file = pkgs.writeTextFile {
            name = "nix.conf";
            text = lib.concatStringsSep "\n" (
              lib.mapAttrsToList (name: value: "extra-${name} = ${lib.concatStringsSep " " value}") nix_conf
            );
          };

          shellHook = ''
            expor NIX_USER_CONF_FILES="${nix_conf_file}"
          '';
        in
        pkgs.mkShell {
          shellHook = shellHook;
          buildInputs = denApps ++ [
            fmtt
            pkgs.just
            pkgs.nh
          ];
        };
    };
}
