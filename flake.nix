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
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ]
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {

          packages.budgie-desktop = pkgs.callPackage ./packages/budgie-desktop.nix
            {
              budgie-screensaver = self.packages.${system}.budgie-screensaver;
            };
          packages.budgie-screensaver = pkgs.callPackage ./packages/budgie-screensaver.nix { };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
            ];
          };
        }
      )
    // {
      overlays.default = final: prev: {
        budgie-desktop = self.packages.budgie-desktop;
        budgie-screensaver = self.packages.budgie-screensaver;
      };
    };
}
