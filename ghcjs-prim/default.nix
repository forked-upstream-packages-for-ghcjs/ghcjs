{ mkDerivation, base, binary, bytestring, containers, ghc-prim
, stdenv, template-haskell
, lib, ghc, primitive
}:

let
  isGhcjs = ghc.isGhcjs or false;

in mkDerivation {
  pname = "ghcjs-prim";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base binary bytestring containers ghc-prim template-haskell
  ] ++ (lib.lists.optionals isGhcjs [
    primitive
  ]);
  homepage = "http://github.com/ghcjs";
  license = stdenv.lib.licenses.mit;
}
