{ unstable-pkgs, inputs, config, pkgs, lib, ... }:

{
  imports = [ ./programs/dwl.nix ./shell ./git ./nvim ./wezterm ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    mimeApps = { enable = true; };
  };

  programs.dwl.enable = true;

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [ unstable-pkgs.logseq ];
  };

}
