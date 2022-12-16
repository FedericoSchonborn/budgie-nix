# Budgie Overlay

[![Cachix](https://github.com/FedericoSchonborn/nix-budgie/actions/workflows/cachix.yaml/badge.svg)](https://github.com/FedericoSchonborn/nix-budgie/actions/workflows/cachix.yaml)

Nix Flake for Budgie Desktop.

## Installation

### Using Nix Flakes

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.budgie.url = "github:FedericoSchonborn/budgie-nix";
  inputs.budgie.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    nixpkgs,
    budgie,
    ...
  }: {
    nixosConfigurations.nixos = {
      system = "x86_64-linux";
      modules = [
        budgie.nixosModules.default
        {
          nixpkgs.overlays = [budgie.overlays.default];
          services.xserver.desktopManager.budgie.enable = true;
        }
      ];
    };
  };
}
```

## Recipes

### Build All Packages

```shell
$ nix develop
# Inside the `nix develop` shell:
$ just build-all
```

### Run A Virtual Machine

```shell
$ nix develop
# Inside the `nix develop` shell:
$ just demo-vm
```
