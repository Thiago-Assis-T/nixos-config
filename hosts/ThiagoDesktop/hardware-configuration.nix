{ config, lib, ... }:

{
  imports = [ ../../kernel ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/a405280b-55f1-47fa-abdf-56033c2af941";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=root"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/a405280b-55f1-47fa-abdf-56033c2af941";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=home"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/a405280b-55f1-47fa-abdf-56033c2af941";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "subvol=nix"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.x86.msr.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
