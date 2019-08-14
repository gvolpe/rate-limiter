{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:
let
  hp = nixpkgs.haskellPackages.override {
    overrides =
      self: super: with nixpkgs.haskell.lib; {
        primitive = doJailbreak (super.callHackage "primitive" "0.6.3.0" {});
        refined = super.callHackage "refined" "0.4.2.2" {};
        transient = super.callHackage "transient" "0.6.3" {};
      };
  };
in
  hp.callPackage ./rate-limiter.nix {}
