{
  config,
  lib,
  pkgs,
  ...
}:
{

  #imports = [ ./hardening.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.availableKernelModules = [
      "amdgpu"
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [
      "acpi_call"
      "amd-pstate"
      "k10temp"
    ];
    extraModulePackages = [ pkgs.linuxKernel.packages.linux_zen.acpi_call ];

    # For Monero Mining:
    kernel.sysctl = {
      "vm.nr_hugepages" = 3072;
    };
    kernelParams = [
      "amd_pstate=active"
      "default_hugepagesz=2M"
      "hugepagesz=1G"
      "hugepages=3"
    ];
  };
}
