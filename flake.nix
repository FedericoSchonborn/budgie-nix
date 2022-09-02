{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
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
        budgie = import ./modules {budgie-overlay = self.overlays.budgie;};
        default = self.nixosModules.budgie;
      };

      overlays = {
        budgie = import ./overlay.nix;
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
            ./virtual-machine.nix
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
            inherit (self.checks.${system}.pre-commit-hook) shellHook;
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
              jq
              buildAll
              buildVm
              runVm
            ];
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
