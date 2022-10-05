{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    pre-commit-hooks,
    ...
  }:
    {
      nixosModules = {
        budgie = import ./modules {inherit (self) overlays;};
        default = self.nixosModules.budgie;
      };

      overlays = {
        budgie = import ./overlay.nix {inherit (self) packages;};
        default = self.overlays.budgie;
      };
    }
    // flake-utils.lib.eachSystem
    (with flake-utils.lib.system; [
      aarch64-linux
      x86_64-linux
    ])
    (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        packages = import ./packages {inherit pkgs;};

        nixosConfigurations = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            self.nixosModules.budgie
            {nixpkgs.overlays = [self.overlays.budgie];}
            ./virtual-machine.nix
          ];
        };

        devShells.default = import ./shell.nix {
          inherit pkgs;
          inherit system;
          inherit (self) checks;
        };

        checks = {
          pre-commit-hook = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              alejandra.enable = true;
            };
          };
        };

        formatter = pkgs.alejandra;
      }
    );
}
