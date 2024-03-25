{ unstable-pkgs, inputs, config, pkgs, lib, ... }:

{
  imports = [ ../programs/dwl.nix ./shell ./git ./nvim ./wezterm ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    mimeApps = { enable = true; };
  };

  programs.dwl.enable = true;
  programs.foot.enable = true;
  programs.foot.package = unstable-pkgs.foot;
  programs.firefox.enable = true;

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [ wdisplays bemenu unstable-pkgs.logseq ];
    sessionVariables = { MOZ_ENABLE_WAYLAND = 1; };
  };

}
