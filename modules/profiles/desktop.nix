{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.desktop;
  my-slock = pkgs.slock.override { conf = builtins.readFile ../../assets/slock/config.def.h; };
in
{
  options = {
    profiles.desktop = {
      enable = mkEnableOption "Enable desktop profile";
      audio = mkOption {
        default = true;
        description = "Enable audio with desktop profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    profiles.audio.enable = cfg.audio;
    services = {
      xserver = {
        enable = true;
        xkbOptions = "ctrl:swapcaps";
        displayManager = {
          startx.enable = true;
        };
      };
      picom = {
        enable = true;
        vSync = true;
      };
    };
    security.wrappers.slock.source = "${my-slock.out}/bin/slock";
    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        hack-font
      ];
    };
    environment.systemPackages = with pkgs; [
      xss-lock
      my-slock
    ];
  };
}
