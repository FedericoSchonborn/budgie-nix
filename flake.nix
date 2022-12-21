{
  description = "NixOS/Home Manager packages and modules for the Budgie Desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    forAllSystems = f:
      nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"] (system:
        f {
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
        });
  in {
    packages = forAllSystems ({pkgs, ...}: import ./packages {inherit pkgs;});

    overlays = {
      budgie = import ./overlay.nix {inherit (self) packages;};
      default = self.overlays.budgie;
    };

    nixosModules = {
      budgie = import ./modules {inherit (self) overlays;};
      default = self.nixosModules.budgie;
    };

    nixosConfigurations = {
      demo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.budgie
          {
            nixpkgs.overlays = [self.overlays.budgie];
          }
          ./machines/demo
        ];
      };

      install-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.budgie
          {
            nixpkgs.overlays = [self.overlays.budgie];
          }
          ./machines/install-iso
        ];
      };
    };

    devShells = forAllSystems ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          just
          jq
        ];

        shellHook = ''
          just --version
          jq --version
        '';
      };
    });

    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);
  };

  nixConfig = {
    extra-substituters = [
      "https://budgie.cachix.org"
    ];
    extra-trusted-public-keys = [
      "budgie.cachix.org-1:Q8+2iOIXhwAaWq548T+r/oNeJdKEacolRY9sBBtOfeQ="
    ];
  };
}
