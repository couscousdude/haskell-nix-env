{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let
  inherit (nixpkgs) pkgs;
  haskellPackages = if compiler == "default"
                     then pkgs.haskellPackages
                     else pkgs.haskell.packages.${compiler};
in
haskellPackages.shellFor {
  packages = p: [];
  buildInputs = with haskellPackages; [
    cabal-install
    ghc
    haskell-language-server
  ];
}

