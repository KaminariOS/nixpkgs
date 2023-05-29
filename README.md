# My NixOS & Home-manager configuration

Based on [nix-config](https://github.com/gvolpe/nix-config).

## Build

(Change the username in [outputs](outputs/home-conf.nix) to your username)

### CLI only
```console
home-manager switch --flake github:KaminariOS/nixpkgs\?ref=dev#shellhome --extra-experimental-features nix-command --extra-experimental-features flakes
```
