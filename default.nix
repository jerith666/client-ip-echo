{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./client-ip-echo.nix { }