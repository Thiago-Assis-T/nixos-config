{ config, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-Space";
    shortcut = "Space";
    shell = "\${pkgs.bash}/bin/bash";
    terminal = "xterm-256color";
  };
  programs.fzf.tmux = {
    enableShellIntegration = true;
  };
}
