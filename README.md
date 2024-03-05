# language-servers.nix

- [Introduction](#introduction)
- [Angular Language Server](#angular-language-server)


## Introduction

A Nix flake providing various language servers. It allows easy integration into existing development shells (without polluting e.g. `package.json/devDependencies` which probably other developers aren't intersted in if the use a different tooling, i.e. not Nix).

**NOTE**: Language server come and go, as more of them are added to nixpkgs.


## Angular Language Server

It provides `bin/angular-language-server` (aka `ngserver`) from [vscode-ng-language-service](https://github.com/angular/vscode-ng-language-service) with the wrapped command line arguments `--add-flags --ngProbeLocations $out/node_modules --tsProbeLocations $out/node-modules`, which expects `node` in the `$PATH`. A typical usage of this server is to provide just the `--stdio` flag.

Besides the wrapped version it includes `bin/angular-language-server-unwrapped` which expects `nodejs` in the `$PATH` and this one does not set any command line arguments by default. This requires to provide the `--ngProbeLocations ` and the `--ngProbeLocations` arguments to the script.

The currently used packages are visible through [angular-language-server/package.json](./angular-language-server/package.json).


## How to use this?

Include the flake into your flake which defines the dev shell, e.g.:

``` nix
{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    language-servers.url = git+https://git.sr.ht/~bwolf/language-servers.nix;
    language-servers.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, language-servers }:
    let
	    system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs-18_x
          language-servers.packages.${system}.angular-language-server
        ];
      };
    };
}
```


## Contributions

Contributions are welcome as patches to the [mailing list](https://lists.sr.ht/~bwolf/public-inbox).


## License

[ISC](./LICENSE)
