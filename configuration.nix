# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, hosts, dwl-src, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/powermanagement.nix
    ./modules/monero/default.nix
    ./package/slstatus/default.nix
    ./package/dwl/default.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  systemd.services.bugfixSuspend-GPP0 = {
    enable = lib.mkDefault true;
    description = "Fix crash on wakeup from suspend/hibernate (b550 bugfix)";
    unitConfig = { Type = "oneshot"; };
    serviceConfig = {
      User = "root"; # root may not be necessary
      # check for gppN, disable if enabled
      # lifted from  https://www.reddit.com/r/gigabyte/comments/p5ewjn/comment/ksbm0mb/ /u/Demotay
      ExecStart =
        "-${pkgs.bash}/bin/bash -c 'if grep 'GPP0' /proc/acpi/wakeup | grep -q 'enabled'; then echo 'GPP0' > /proc/acpi/wakeup; fi'";
      RemainAfterExit =
        "yes"; # required to not toggle when `nixos-rebuild switch` is ran

    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.bugfixSuspend-GPP8 = {
    enable = lib.mkDefault true;
    description = "Fix crash on wakeup from suspend/hibernate (b550 bugfix)";
    unitConfig = { Type = "oneshot"; };
    serviceConfig = {
      User = "root";
      ExecStart =
        "-${pkgs.bash}/bin/bash -c 'if grep 'GPP8' /proc/acpi/wakeup | grep -q 'enabled'; then echo 'GPP8' > /proc/acpi/wakeup; fi''";
      RemainAfterExit = "yes";
    };
    wantedBy = [ "multi-user.target" ];
  };
  boot.kernelParams = [
    "amd_pstate=active"
    "amdgpu.sg_display=0"
    "initcall_blacklist=acpi_cpufreq_init"
    "usbcore.autosuspend=-1"
  ];

  security.polkit.enable = true;
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
          "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'slstatus -s | dbus-launch --exit-with-session dwl'";
        user = "thiago";
      };

    };

  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkb.layout = "br";
  users.users.thiago = {
    isNormalUser = true;
    extraGroups =
      [ "video" "seat" "wheel" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ mate.mate-polkit geekbench firefox ];
  };

  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?

}
