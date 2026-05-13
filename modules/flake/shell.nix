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
        in
        pkgs.mkShell {
          buildInputs = denApps ++ [
            fmtt
            pkgs.just
            pkgs.nh
          ];
        };
    };
}
