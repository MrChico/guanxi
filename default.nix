{ compiler ? "ghc884", pkgs ? import <nixpkgs> {} }:

let
 myHaskellPackages = pkgs.haskellPackages.override {
    overrides = hself: hsuper: {
      guanxi =
        hself.callCabal2nix
          "guanxi"
          (./.)
          {};
    };
 };

  shell = myHaskellPackages.shellFor {
    packages = p: [
      p.guanxi
    ];
    buildInputs = with pkgs.haskellPackages; [
      cabal-install
    ];
    withHoogle = true;
  };

  exe = pkgs.haskell.lib.justStaticExecutables (myHaskellPackages.act);
in
{
  inherit shell;
  inherit exe;
}
