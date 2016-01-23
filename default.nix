let
  pkgs = import <nixpkgs> {};
  inherit (pkgs.haskell.lib) overrideCabal;
in with pkgs;
rec {
  dynamicCabal2nix = dir: pkgs.runCommand "dynamic-cabal2nix" {
    nativeBuildInputs = [ pkgs.haskellPackages.cabal2nix ];
  } "cabal2nix ${dir} > $out";

  stage0Pkgs = haskell.packages.lts-3_6.override {
    overrides = self: super: {
      ghcjs = overrideCabal (self.callPackage (dynamicCabal2nix ./ghcjs) {}) (drv: {
        doCheck   = false;
        doHaddock = false;
        passthru = {
          isGhcjs = true;
          nativeGhc = stage0Pkgs.ghc;
          inherit nodejs;
        };
      });
      ghcjs-prim = self.callPackage ./ghcjs-prim {}; # cannot autogenerate for now
    };
  };

  ghcFork = fetchFromGitHub {
    owner = "forked-upstream-packages-for-ghcjs";
    repo = "ghc";
    rev = "4f290c40c9c521670780ae646cf566a3a3621557";
    sha256 = "0636gcjq54jf02953m4gk7n1nyzd0pm2dwj9jmjv05hw17kyza06";
  };

  stage1Pkgs = haskell.packages.lts-3_6.override {
    ghc = stage0Pkgs.ghcjs;
    overrides = self: super: {
      ghc-prim = self.callPackage (dynamicCabal2nix "${ghcFork}/libraries/ghc-prim") {};
      # Still tries to build hscolour... 
      #base = overrideCabal (self.callPackage (dynamicCabal2nix "${ghcFork}/libraries/base") {}) (drv: {
      #  hyperlinkSource = false;
      #}); 
      integer-gmp = self.callPackage (dynamicCabal2nix "${ghcFork}/libraries/integer-gmp") {};
      template-haskell = self.callPackage (dynamicCabal2nix "${ghcFork}/libraries/template-haskell") {};

      ghcjs-prim = self.callPackage ./ghcjs-prim {}; # cannot autogenerate for now
    };
  };
}
