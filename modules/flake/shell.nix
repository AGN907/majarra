{
  inputs,
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

          formatter = inputs.self.formatter.${system};
          fmtt = pkgs.writeShellApplication {
            name = "fmtt";
            text = ''
              ${lib.getExe formatter} "$@"
            '';
          };

          allfollow = inputs.nix-auto-follow.packages.${system}.default;
        in
        pkgs.mkShell {
          buildInputs = [
            fmtt
            allfollow
            pkgs.just
          ];
        };
    };
}
