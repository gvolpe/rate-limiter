{ mkDerivation, base, refined, stdenv, template-haskell, transient
}:
mkDerivation {
  pname = "rate-limiter";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base refined template-haskell transient
  ];
  executableHaskellDepends = [
    base refined template-haskell transient
  ];
  license = stdenv.lib.licenses.asl20;
}
