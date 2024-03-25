{ config, unstable-pkgs }: {

  programs.foot = {
    enable = true;
    package = unstable-pkgs.foot;

  };
}
