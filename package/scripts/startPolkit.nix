{ pkgs, ... }:
pkgs.writeShellScriptBin "startPolkit" ''
  exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
''
