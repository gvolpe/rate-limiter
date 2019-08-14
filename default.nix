{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./rate-limiter.nix { }
