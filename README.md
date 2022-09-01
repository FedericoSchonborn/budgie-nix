# Budgie Overlay

Nix Flake for Budgie Desktop.

## Run On A Virtual Machine

```shell
$ nixos-rebuild build-vm --flake .#vm
Done.  The virtual machine can be started by running /nix/store/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA-nixos-vm/bin/run-nixos-vm
$ ./result/bin/run-nixos
# User/pass: vm/vm
```

## Building All Packages

```shell
# Inside a nix-shell/nix develop shell:
$ buildAll
```
