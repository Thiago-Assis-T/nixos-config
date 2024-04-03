{ pkgs, slstatus-src, ... }:
{
  environment.systemPackages = with pkgs; [
    (slstatus.overrideAttrs (_: {
      src = slstatus-src;
    }))
  ];
}
