{
  description = "Trezor Nostr Signer Workshop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nodePackages.prettier
          ];

          shellHook = ''
            echo ""
            echo "Available tools:"
            echo "  prettier  - Code formatter"
            echo ""
            echo "To format all files in the project, run:"
            echo "  prettier --write ."
            echo ""
          '';
        };
      });
}
