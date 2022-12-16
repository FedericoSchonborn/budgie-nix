# budgie-nix

[![Cachix](https://github.com/FedericoSchonborn/nix-budgie/actions/workflows/cachix.yaml/badge.svg)](https://github.com/FedericoSchonborn/nix-budgie/actions/workflows/cachix.yaml)

Nix packaging and NixOS integration modules for the Budgie desktop.

## Installation

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
