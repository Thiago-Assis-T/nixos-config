{ config, pkgs, xplr-tree-view, ... }: {

  programs.xplr = {
    enable = true;
    #plugins = { tree-view = xplr-tree-view; };
    extraConfig = builtins.readFile ./lua/xplr.lua;
  };

}
