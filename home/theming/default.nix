{ config, pkgs, ... }:
{

  gtk = {
    enable = true;
    iconTheme = {
      name = "Solarc";
      package = "pkgs.solarc-gtk-theme";
    };
  };
}
