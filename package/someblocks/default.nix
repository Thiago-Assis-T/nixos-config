{ config, pkgs, lib, stdenv, someblocks-src, ... }:
stdenv.mkDerivation {
  pname = "someblocks";
  version = "1.0.1";

  src = someblocks-src;

  buildInputs = with pkgs; [ ];

  patches = [ ];

  makeFlags = [ "PREFIX=$(out)/usr/local" "MANPREFIX=$(man)/share/man" ];

}
