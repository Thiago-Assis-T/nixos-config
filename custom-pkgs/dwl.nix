{ config, pkgs, lib, dwl-source, stdenv, ... }:

stdenv.mkDerivation {
  pname = "dwl";
  version = "0.5";
  src = dwl-source;

  nativeBuildInputs = [ installShellFiles pkg-config wayland-scanner ];

  buildInputs = [
    libinput
    libxcb
    libxkbcommon
    pixman
    wayland
    wayland-protocols
    wlroots
    libX11
    xcbutilwm
    xwayland
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp a.out $out/bin/dwl
  '';

}
