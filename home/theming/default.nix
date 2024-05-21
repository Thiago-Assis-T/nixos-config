{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.package = pkgs.solarc-gtk-theme;
    theme.name = "SolArc-Dark";
  };
}
