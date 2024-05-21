{ ... }:
{

  #environment.systemPackages = with pkgs; [ ];
  powerManagement = {
    enable = false;
    powertop.enable = false;
  };
  services = {
    auto-cpufreq = {
      enable = false;
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
      enable = false;
      useStockConfig = true;
    };
  };
}
