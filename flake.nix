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
      nixosModules = {
        budgie = {
          nixpkgs.overlays = [self.overlays.budgie];
          imports = [
            ./nixos.nix
          ];
        };

        default = self.nixosModules.budgie;
      };

      overlays = {
        budgie = import ./overlay.nix;
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
        pkgs = import nixpkgs {inherit system;};
      in {
        packages = import ./packages.nix {inherit pkgs;};

        nixosConfigurations = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            self.nixosModules.budgie
            ./vm.nix
          ];
        };

        devShells.default = let
          buildAll = pkgs.writeShellScriptBin "buildAll" ''
            nix flake show --json | jq  '.packages."${system}"|keys[]' | xargs -I {} nix build .#{} -o result-{}
          '';
          buildVm = pkgs.writeShellScriptBin "buildVm" "nixos-rebuild build-vm --flake .#${system}";
          runVm = pkgs.writeShellScriptBin "runVm" "buildVm && ./result/bin/run-nixos-vm";
        in
          pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
              jq
              buildAll
              buildVm
              runVm
            ];
          };

        formatter = pkgs.alejandra;
      }
    );
}
