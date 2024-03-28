{ pkgs, inputs, config, ... }:

{
  imports = [ ./foot ./shell ./git ./nvim ./wezterm ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    mimeApps = { enable = true; };
  };

  programs.firefox.enable = true;

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [
      cpu-x
      lm_sensors
      btop
      mpv
      youtube-tui
      neofetch
      wbg
      dmenu-wayland
    ];
    sessionVariables = { MOZ_ENABLE_WAYLAND = 1; };

  };

}
