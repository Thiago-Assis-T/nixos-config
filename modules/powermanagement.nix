{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ ];
  powerManagement = {
    enable = true;
    powertop.enable = false;
    cpuFreqGovernor = "performance";
  };
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "performance";
          turbo = "always";
        };
        charger = {
          governor = "performance";
          turbo = "always";
        };
      };
    };
    power-profiles-daemon.enable = false;
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
  };
}
