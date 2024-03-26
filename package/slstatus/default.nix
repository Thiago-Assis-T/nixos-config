{ pkgs, stdenv, lib, slstatus-src, ... }: {
  environment.systemPackages =
    [ (pkgs.slstatus.overrideAttrs (_: { src = slstatus-src; })) ];
}
