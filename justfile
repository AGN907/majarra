hostname := `hostname -s`

fmt *args:
  fmtt {{args}}
build host=hostname *args:
  {{hostname}} build {{args}}
switch host=hostname *args:
  {{hostname}} switch --ask {{args}}
test host=hostname *args:
  {{hostname}} test --ask {{args}}
boot host=hostname *args:
  {{hostname}} boot {{args}}
write:
  nix run .#write-flake
update *args:
  nix flake update {{args}}
vm:
  nix run .#vm
add-secret:
  sops modules/secrets/secrets.yaml
check:
  nix flake check
