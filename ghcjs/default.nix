{ mkDerivation, aeson, array, attoparsec, base, base16-bytestring
, bin-package-db, binary, bytestring, Cabal, containers, cryptohash
, data-default, deepseq, directory, filepath, ghc, ghc-paths
, ghcjs-prim, haddock-api, hashable, haskell-src-exts
, haskell-src-meta, http-types, HUnit, lens, lifted-base, mtl
, network, optparse-applicative, parallel, parsec, process, random
, regex-posix, safe, shelly, split, stdenv, stringsearch, syb
, system-fileio, system-filepath, template-haskell, terminfo
, test-framework, test-framework-hunit, text, text-binary, time
, transformers, transformers-compat, unix, unordered-containers
, vector, wai, wai-app-static, wai-extra, wai-websockets, warp
, webdriver, websockets, wl-pprint-text, yaml
}:
mkDerivation {
  pname = "ghcjs";
  version = "0.2.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson array attoparsec base base16-bytestring bin-package-db binary
    bytestring Cabal containers cryptohash data-default deepseq
    directory filepath ghc ghc-paths ghcjs-prim hashable
    haskell-src-exts haskell-src-meta lens mtl optparse-applicative
    parallel parsec process regex-posix safe split stringsearch syb
    system-filepath template-haskell text text-binary time transformers
    unordered-containers vector wl-pprint-text yaml
  ];
  executableHaskellDepends = [
    base bin-package-db binary bytestring Cabal containers directory
    filepath ghc haddock-api process terminfo transformers
    transformers-compat unix
  ];
  testHaskellDepends = [
    aeson base bytestring data-default deepseq directory http-types
    HUnit lens lifted-base network optparse-applicative process random
    shelly system-fileio system-filepath test-framework
    test-framework-hunit text time transformers unordered-containers
    wai wai-app-static wai-extra wai-websockets warp webdriver
    websockets yaml
  ];
  license = stdenv.lib.licenses.mit;
}
