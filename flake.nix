{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
  in rec {
    nixosModules = {
      budgie = import ./modules {inherit (self) overlays;};
      default = self.nixosModules.budgie;
    };

    overlays = {
      budgie = import ./overlay.nix {inherit (self) packages;};
      default = self.overlays.budgie;
    };

    packages = forAllSystems (system: import ./packages {pkgs = nixpkgs.legacyPackages.${system};});

    nixosConfigurations.budgie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        self.nixosModules.budgie
        {
          nixpkgs.overlays = [self.overlays.budgie];
        }
        ./virtual-machine.nix
      ];
    };

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          just
          jq
        ];

        shellHook = ''
          ${checks.${system}.pre-commit-hook.shellHook}
        '';
      };
    });

    checks = forAllSystems (system: {
      pre-commit-hook = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
        };
      };
    });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  nixConfig = {
    extra-substituters = [
      "https://budgie.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "budgie.cachix.org-1:Q8+2iOIXhwAaWq548T+r/oNeJdKEacolRY9sBBtOfeQ="
    ];
  };
}
