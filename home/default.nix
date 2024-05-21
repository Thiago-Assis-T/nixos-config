{ pkgs, ... }:

{
  imports = [
    ./foot
    ./shell
    ./git
    ./nvim
    ./tmux
    ./theming
    # TODO: Fix the theme...
  ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    portal = {
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
        xdg-desktop-portal-hyprland
      ];
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "floorp.desktop";
        "x-scheme-handler/http" = "floorp.desktop";
        "x-scheme-handler/https" = "floorp.desktop";
        "x-scheme-handler/about" = "floorp.desktop";
        "x-scheme-handler/unknown" = "floorp.desktop";
      };
    };
  };

  programs.mpv.enable = true;

  programs.zathura.enable = true;

  fonts.fontconfig.enable = true;

  services.wlsunset = {
    enable = true;
    latitude = "-22";
    longitude = "-43";
  };

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "22.11";
    packages = with pkgs; [
      tree
      freecad
      osu-lazer-bin
      floorp
      youtube-music
      pavucontrol
      util-linux
      logseq
      grim
      slurp
      exercism
      bats
      nerdfonts
      ani-cli
      manga-cli
      ytfzf
      wl-clipboard
      lm_sensors
      btop
      youtube-tui
      fastfetch
      wbg
      dmenu-wayland
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      DEFAULT_BROWSER = "${pkgs.floorp}/bin/floorp";
      MOZ_ENABLE_WAYLAND = 1;
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland-egl";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "dwl";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "dwl";
    };
  };

  xdg = {
    mime.enable = true;
  };
}
