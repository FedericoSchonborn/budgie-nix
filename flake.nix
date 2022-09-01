{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.budgie
          ./systems/vm
        ];
      };

      nixosModules = {
        budgie = {
          nixpkgs.overlays = [self.overlays.budgie];
          imports = [
            ./modules/budgie
          ];
        };

        default = self.nixosModules.budgie;
      };

      overlays = {
        budgie = import ./overlays/budgie;
        default = self.overlays.budgie;
      };
    }
    // flake-utils.lib.eachSystem [
      "aarch64-linux"
      "i686-linux"
      "powerpc64le-linux"
      "riscv64-linux"
      "x86_64-linux"
    ]
    (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = import ./packages {inherit pkgs;};

        devShells.default = let
          buildAll = pkgs.writeShellScriptBin "buildAll" ''
            nix flake show --json | jq  '.packages."${system}"|keys[]' | xargs -I {} nix build .#{} -o result-{}
          '';
        in
          pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
              jq
              buildAll
            ];
          };

        formatter = pkgs.alejandra;
      }
    );
}
