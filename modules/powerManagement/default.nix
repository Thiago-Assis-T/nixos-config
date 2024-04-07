{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ ];
  powerManagement = {
    enable = true;
    powertop.enable = false;
    # cpuFreqGovernor = "performance";
  };
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "performance";
          turbo = "auto";
          energy_performance_preference = "performance";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
          energy_performance_preference = "performance";
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
