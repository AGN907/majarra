# Majarra - Agn's Nix galaxy

My infra built using [den](https://den.oeiuwq.com/).

## Everyday Usage

```console
just switch
just update
just write
```

## Users

Currently only user [agn](modules/agn.nix) is provided.

## Hosts

| Host | Platform | Users | 
| ---- | -------- | ----- |
| alkaid | NixOS | agn |

---

## Devshell
Load [shell.nix](shell.nix) using direnv `.envrc`.

```bash
# .envrc
use flake
```

Other useful commands defined at [Justfile](justfile)
