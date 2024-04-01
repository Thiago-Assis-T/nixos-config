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
        steam =
          "gamescope -W 1920 -H 1080 -e --framerate-limit 60 -F fsr --fsr-sharpness 15 --force-windows-fullscreen -- steam";

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
