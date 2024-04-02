{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ htop bat fd ];
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        htop = "sudo htop";
        cat = "bat";
        ytfzf = "ytfzf -t";
        steam = "gamescope -W 1920 -H 1080 -e --framerate-limit 65 -- steam";

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
