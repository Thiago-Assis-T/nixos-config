{ unstable-pkgs, inputs, config, pkgs, lib, ... }:

{
  imports = [ ../programs/dwl.nix ./foot ./shell ./git ./nvim ./wezterm ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    mimeApps = { enable = true; };
  };

  programs.dwl.enable = true;
  programs.firefox.enable = true;

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [ slstatus wbg dmenu-wayland unstable-pkgs.logseq ];
    sessionVariables = { MOZ_ENABLE_WAYLAND = 1; };
  };

}
