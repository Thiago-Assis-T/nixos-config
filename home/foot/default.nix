{ config, pkgs, ... }: {
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        term = "xterm-256color";
        font = "ShureTechMono NerdFont:size=12";
        dpi-aware = "yes";
      };
      colors = { alpha = "0.8"; };
      mouse = { hide-when-typing = "yes"; };
    };
  };
}
