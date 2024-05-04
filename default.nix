{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let
  inherit (nixpkgs) pkgs;

  haskellPackages = if compiler == "default"
                     then pkgs.haskellPackages
                     else pkgs.haskell.packages.${compiler};

in
  haskellPackages.developPackage {
    root = ./.;
    modifier = drv:
      pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages; [
        cabal-install
        ghcid
        haskell-language-server
      ]);
  }
