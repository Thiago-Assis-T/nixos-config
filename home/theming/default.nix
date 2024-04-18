{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Dark";
  };
}
