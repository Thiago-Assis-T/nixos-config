{ config, pkgs, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "ShureTechMono NerdFont:size=12";
        dpi-aware = "yes";
      };

      colors = {
        alpha = "0.9";

        background = "002b36";
        foreground = "839496";

        regular0 = "073642";
        regular1 = "dc322f";
        regular2 = "859900";
        regular3 = "b58900";
        regular4 = "268bd2";
        regular5 = "d33682";
        regular6 = "2aa198";
        regular7 = "eee8d5";

        bright0 = "08404f";
        bright1 = "e35f5c";
        bright2 = "9fb700";
        bright3 = "d9a400";
        bright4 = "4ba1de";
        bright5 = "dc619d";
        bright6 = "32c1b6";
        bright7 = "ffffff";

        selection-foreground = "93a1a1";
        selection-background = "073642";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
