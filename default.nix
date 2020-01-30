{ pkgs ? import <nixpkgs> {} }:
  pkgs.haskellPackages.callCabal2nix "deriving-date" ./. {}
