{ config, pkgs, lib, custom-dwl, ... }:
with lib;
let
  cfg = config.programs.dwl;
  dwlPackage = import ../package/dwl.nix {
    inherit pkgs;
    inherit (cfg)
    ;
    inherit custom-dwl;
  };
in {
  options.programs.dwl = {
    enable = mkEnableOption "dwl";
    package = mkOption {
      type = types.package;
      default = dwlPackage;
    };
  };

  config = mkIf cfg.enable { home.packages = [ cfg.package ]; };

}
