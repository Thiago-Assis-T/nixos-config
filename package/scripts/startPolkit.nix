{ pkgs, ... }:
let
  startPolkit = pkgs.writeShellScriptBin "startPolkit" ''
    exec ${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1 &
  '';
in
{
  environment.systemPackages = with pkgs; [
    startPolkit
    mate.mate-polkit
  ];
}
