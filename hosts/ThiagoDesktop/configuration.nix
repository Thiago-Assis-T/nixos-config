{ pkgs, hosts, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/powerManagement
    ../../modules/gaming
    ../../package/slstatus
    ../../package/dwl
    ../../package/scripts/startPolkit.nix
  ];

  programs.dconf.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services = {
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-media-tags-plugin
      thunar-archive-plugin
      thunar-volman
    ];
  };

  nixpkgs.hostPlatform = {
    gcc.arch = "znver3";
    gcc.tune = "znver3";
    system = "x86_64-linux";
  };

  boot.initrd.systemd.dbus.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.seatd.enable = true;
  sound = {
    enable = true;
    enableOSSEmulation = true;
    mediaKeys = {
      enable = true;
      volumeStep = "1%";
    };
  };

  xdg = {
    autostart.enable = true;
    sounds.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [ xdg-desktop-portal-wlr ];
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

  services.hdapsd.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.fstrim.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  networking.hostName = "ThiagoDesktop";
  networking.hostFiles = [ hosts ];
  networking.networkmanager = {
    enable = true;
    wifi = {
      backend = "iwd";
      macAddress = "random";
    };
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.greetd = {
    enable = true;
    restart = true;
    package = with pkgs; greetd.tuigreet;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'slstatus -s | dbus-run-session dwl'";
        user = "thiago";
      };
    };
  };

  services.xserver.xkb.layout = "br";
  users.users.thiago = {
    isNormalUser = true;
    extraGroups = [
      "video"
      "seat"
      "wheel"
      "audio"
    ];
  };

  networking.firewall.enable = true;
  system.stateVersion = "23.11";
}
