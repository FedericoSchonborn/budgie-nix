{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.budgie
          ./vm.nix
        ];
      };

      nixosModules = {
        budgie = import ./nixos.nix { inherit self; };
        default = self.nixosModules.budgie;
      };

      overlays = {
        budgie = import ./overlay.nix;
        default = self.overlays.budgie;
      };
    } // flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ]
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages = import ./packages.nix { inherit pkgs; };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
            ];
          };
        }
      );
}
