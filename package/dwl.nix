{ pkgs, custom-dwl, ... }:
pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: { src = custom-dwl; })
