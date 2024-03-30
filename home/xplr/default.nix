{ config, pkgs, ... }: {

  programs.xplr = {
    enable = true;
    plugins = {
      tree-view = fetchFromGitHub {
        owner = "sayanarijit";
        repo = "tree-view.xplr";
      };

    };
    extraConfig = builtins.readFile ./lua/xplr.lua;
  };

}
