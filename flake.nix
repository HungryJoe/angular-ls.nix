{
  description = "The Angular Language server (lsp).";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = {config, pkgs, ...}: {
          packages.angular-language-server =
            pkgs.callPackage ./angular-language-server { nodejs=pkgs.nodejs-18_x; };
          devShells.default =
            pkgs.mkShell { buildInputs = with pkgs; [ nodejs-18_x yarn ]; };
      
      };
    };
}
