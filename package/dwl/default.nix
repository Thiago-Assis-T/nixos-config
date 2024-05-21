{ pkgs, dwl-src, ... }:
{
  environment.systemPackages = [
    (pkgs.dwl.overrideAttrs (_: {
      buildInputs = with pkgs; [
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
