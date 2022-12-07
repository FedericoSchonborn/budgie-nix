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
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
  in {
    nixosModules = {
      budgie = import ./modules {inherit (self) overlays;};
      default = self.nixosModules.budgie;
    };

    overlays = {
      budgie = import ./overlays/budgie {inherit (self) packages;};
      default = self.overlays.budgie;
    };

    packages = forAllSystems (system: import ./packages {pkgs = nixpkgs.legacyPackages.${system};});

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

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          just
          jq
          alejandra
          nil
          statix
        ];

        shellHook = ''
          just --version
          jq --version
          alejandra --version
          nil --version
          statix --version
        '';
      };
    });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
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
