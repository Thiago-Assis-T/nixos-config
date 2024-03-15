{ config, pkgs, ... }: {
  home = { packages = with pkgs; [ nerdfonts ]; };
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./lua/wezterm.lua;
  };
}
