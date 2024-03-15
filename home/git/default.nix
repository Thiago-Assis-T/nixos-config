{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Thiago-Assis-T";
    userEmail = "thiago.assisfernandes@gmail.com";
    extraConfig = {
      color = { ui = "auto"; };
      pull = { rebase = true; };
      core = { editor = "nvim"; };
    };
    includes = [{
      contents = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    }];
  };
}
