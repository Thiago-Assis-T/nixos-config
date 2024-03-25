{ unstable-pkgs, custom-dwl, lib, stdenv, ... }:
stdenv.mkDerivation (finalAttrs: {
  pname = "dwl";
  version = "0.5";
  src = custom-dwl;

  nativeBuildInputs = with unstable-pkgs; [
    installShellFiles
    pkg-config
    wayland-scanner
  ];

  buildInputs = with unstable-pkgs; [
    libinput
    wayland
    wlroots
    libxkbcommon
    wayland-protocols
    pkg-config
    pixman
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilwm
    xwayland
  ];

  outputs = [ "out" "man" ];

  patches = [
    ./patches/autostart.patch
    ./patches/ipc.patch
    ./patches/regions.patch

  ];

  # postPatch = let configFile = ./config.h;
  #in ''
  #  cp ${configFile} config.def.h;
  #'';

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
    "WAYLAND_SCANNER=wayland-scanner"
    "PREFIX=$(out)"
    "MANDIR=$(man)/share/man"
  ];

  meta = {
    homepage = "https://codeberg.com/dwl/dwl/";
    description = "Dynamic window manager for Wayland";
    longDescription = ''
      dwl is a compact, hackable compositor for Wayland based on wlroots. It is
      intended to fill the same space in the Wayland world that dwm does in X11,
      primarily in terms of philosophy, and secondarily in terms of
      functionality. Like dwm, dwl is:

      - Easy to understand, hack on, and extend with patches
      - One C source file (or a very small number) configurable via config.h
      - Limited to 2000 SLOC to promote hackability
      - Tied to as few external dependencies as possible
    '';
    changelog =
      "https://codeberg.org/dwl/dwl/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = [ lib.maintainers.AndersonTorres ];
    mainProgram = "dwl";
  };
})
