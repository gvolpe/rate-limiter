{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:
let
  hp = nixpkgs.haskellPackages.override {
    all-cabal-hashes = nixpkgs.fetchurl {
      url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/4db96602103463d72e59ce214d0da8af35405f07.tar.gz";
      sha256 = "14r7m3555ngfafk2wgdj4lnv7zzajcc4j4fiws4k3kr3xwbrwrxr";
    };
  };
  newTransient = hp.callHackage "transient" "0.6.3" {};
in
  hp.callPackage ./rate-limiter.nix {
    transient = newTransient;
  }
