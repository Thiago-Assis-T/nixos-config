{ config, ... }: {
  powerManagement = {
    enable = true;
    #powertop.enable = true;
    cpuFreqGovernor = "performance";
  };
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "performance";
          turbo = "auto";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
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
