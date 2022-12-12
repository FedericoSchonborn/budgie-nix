# Budgie Overlay

[![Cachix](https://github.com/FedericoSchonborn/nix-budgie/actions/workflows/cachix.yaml/badge.svg)](https://github.com/FedericoSchonborn/nix-budgie/actions/workflows/cachix.yaml)

Nix Flake for Budgie Desktop.

## Build All Packages

```shell
$ nix develop
# Inside the `nix develop` shell:
$ just build-all
```

## Run A Virtual Machine

```shell
$ nix develop
# Inside the `nix develop` shell:
$ just demo-vm
```
