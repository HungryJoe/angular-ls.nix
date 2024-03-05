{
  description = "Various Language Servers (lsp).";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nodejs = pkgs.nodejs-18_x;
    in {
      packages.angular-language-server =
        pkgs.callPackage ./angular-language-server { inherit nodejs; };
      packages.svelte-language-server =
        pkgs.callPackage ./svelte-language-server { };
      packages.vscode-langservers-extracted =
        pkgs.callPackage ./vscode-langservers-extracted { };

      devShells.${system}.default =
        pkgs.mkShell { buildInputs = with pkgs; [ nodejs-18_x yarn ]; };
    };
}
