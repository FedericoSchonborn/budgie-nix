{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.budgie-screensaver = pkgs.callPackage ./packages/budgie-screensaver.nix { };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rnix-lsp
            nixpkgs-fmt
          ];
        };
      }
    );
}
