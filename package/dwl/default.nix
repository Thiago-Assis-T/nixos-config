{ unstable-pkgs, dwl-src, lib, stdenv, ... }: {
  environment.systemPackages = [
    (unstable-pkgs.dwl.overrideAttrs (_: {
      buildInputs = with unstable-pkgs; [
        # for the bar:
        fcft
        libdrm
        #for dwl:
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
      src = dwl-src;
    }))
  ];
}
