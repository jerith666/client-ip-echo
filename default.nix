{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc844" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./client-ip-echo.nix { }