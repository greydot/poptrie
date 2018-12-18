{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "poptrie";

  buildInputs = [ gnumake clang ];

  shellHook = ''
  '';
}
