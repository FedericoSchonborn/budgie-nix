# Budgie Overlay

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
$ just run-vm # or run-clean-vm if you want a clean machine.
```
