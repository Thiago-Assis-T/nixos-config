{ config, unstable-pkgs, pkgs, lib, custom-dwl, ... }:
let
  cfg = config.programs.dwl;
  dwlPackage = pkgs.callPackage (import ../package/dwl) {
    inherit unstable-pkgs;
    inherit (cfg)
    ;
    inherit custom-dwl;
  };
in {
  options.programs.dwl = {
    enable = lib.mkEnableOption "dwl";
    package = lib.mkOption {
      type = lib.types.package;
      default = dwlPackage;
    };
  };

  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };

}
