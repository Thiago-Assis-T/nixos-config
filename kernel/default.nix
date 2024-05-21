{ pkgs }:
{

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
      "amdgpu"
      "amd-pstate"
      "acpi-cpufreq"
      "k10temp"
    ];

    kernelParams = [ "amd_pstate=enable" ];
  };
}
