{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ fd ];
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        htop = "sudo htop";
        cat = "bat";
        vim = "nvim";
        vi = "nvim";

      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };

}
