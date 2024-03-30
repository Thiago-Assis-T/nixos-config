{ config, pkgs, nixvim, ... }: {
  programs.nixvim = {
    colorscheme.ayu.enable = true;
    clipboard.providers.wl-copy.enable = true;
    plugins = {
      treesitter = {
        enable = true;
        ensureInstalled = "all";
        folding = true;
        indent = true;
        nixvimInjections = true;
        incrementalSelection.enable = true;
      };
      treesitter-context = {
        enable = true;
        lineNumbers = true;
      };
      treesitter-refactor = {
        enable = true;
        highlightCurrentScope.enable = true;
        navigation.enable = true;
        smartReaname.enable = true;
      };

      lualine.enable = true;
      nix.enable = true;
      nix-develop.enable = true;
    };

  };

}
