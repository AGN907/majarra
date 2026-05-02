hostname := `hostname -s`

fmt *args:
  fmtt {{args}}
build host=hostname *args:
  nix run .#{{hostname}} -- build
switch host=hostname *args:
  nix run .#{{hostname}} -- switch
write:
  nix run .#write-flake
update:
  nix flake update
vm:
  nix run .#vm
