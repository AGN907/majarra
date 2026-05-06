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

          autoFollow = inputs.nix-auto-follow.packages.${system}.default;
        in
        pkgs.mkShell {
          buildInputs = denApps ++ [
            fmtt
            autoFollow
            pkgs.just
            pkgs.nh
          ];
        };
    };
}
