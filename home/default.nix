{ pkgs, inputs, config, ... }:

{
  imports = [ ./xplr ./foot ./shell ./git ./nvim ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    mimeApps = { enable = true; };
  };

  programs.firefox = { enable = true; };

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [
      nerdfonts
      asciiquarium-transparent
      ani-cli
      manga-cli
      ytfzf
      wl-clipboard
      lm_sensors
      btop
      mpv
      youtube-tui
      neofetch
      wbg
      dmenu-wayland
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      GDK_BACKEND = "wayland,x11";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "dwl";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "dwl";
    };

  };

  xdg = { mime.enable = true; };
}
