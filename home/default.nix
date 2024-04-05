{
  pkgs,
  inputs,
  config,
  ...
}:

{
  imports = [
    ./foot
    ./shell
    ./git
    ./nvim
    ./tmux
  ];
  services.gnome-keyring.enable = true;
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefos.desktop";
      };
    };
  };

  programs.firefox = {
    enable = true;
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
      osu-lazer-bin
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
      neofetch
      wbg
      dmenu-wayland
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
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
