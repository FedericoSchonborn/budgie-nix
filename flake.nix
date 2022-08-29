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
          packages = {
            budgie-desktop = pkgs.callPackage ./packages/budgie-desktop.nix
              {
                budgie-screensaver = self.packages.${system}.budgie-screensaver;
              };

            budgie-screensaver = pkgs.callPackage ./packages/budgie-screensaver.nix { };
            budgie-control-center = pkgs.callPackage ./packages/budgie-control-center.nix { };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
            ];
          };
        }
      )
    // {
      overlays.default = final: prev: self.packages;
    };
}
