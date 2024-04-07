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
          governor = "powersave";
          turbo = "auto";
          energy_performance_preference = "power";
        };
        charger = {
          governor = "powersave";
          turbo = "auto";
          energy_performance_preference = "power";
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
