{ pkgs, slstatus-src, ... }:
{
  environment.systemPackages = [
    (pkgs.slstatus.overrideAttrs (_: {
      src = slstatus-src;
    }))
  ];
}
