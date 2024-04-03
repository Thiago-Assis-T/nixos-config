{ pkgs, dwl-src, ... }:
let
in
#dwlSession = (pkgs.writeTextDir "share/wayland-sessions/dwl.desktop" ''
#  [Desktop Entry]
#  Name=dwl
#  Comment=dwm for wayland
#  Exec=${pkgs.dwl}/bin/dwl
#  Type=Application
#'').overrideAttrs (_: { passthru.providedSessions = [ "dwl" ]; });
{
  #services.xserver.displayManager.sessionPackages = [ dwlSession ];
  environment.systemPackages = with pkgs; [
    (dwl.overrideAttrs (_: {
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
