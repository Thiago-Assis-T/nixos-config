# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, hosts, dwl-src, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/powerManagement
    ../../modules/monero
    ../../package/slstatus
    ../../package/dwl
    ../../package/scripts/startPolkit.nix
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
  environment.systemPackages = with pkgs; [ ];
  services.gnome.gnome-keyring.enable = true;
  services.seatd.enable = true;
  xdg = {
    autostart.enable = true;
    sounds.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [ xdg-desktop-portal-wlr ];
    };
  };

  services.hdapsd.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.fstrim.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  sound.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  services.jack.alsa.enable = true;
  services.jack.alsa.support32Bit = true;

  networking.hostName = "ThiagoDesktop"; # Define your hostname.
  networking.hostFiles = [ hosts ];
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
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
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'slstatus -s | dbus-run-session dwl'";
        user = "thiago";
      };

    };

  };

  services.xserver.xkb.layout = "br";
  users.users.thiago = {
    isNormalUser = true;
    extraGroups =
      [ "video" "seat" "wheel" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };

  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?

}
