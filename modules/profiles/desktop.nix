{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.desktop;
  shared = import ../../shared.nix;
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
        desktopManager = {
          xfce.enable = true;
        };
      };
      picom = {
        enable = true;
        fade = true;
        inactiveOpacity = "0.9";
        shadow = true;
        fadeDelta = 4;
      };
    };
    programs = {
      slock.enable = true;
    };
    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        hack-font
      ];
    };
    environment.systemPackages = with pkgs; [
      xss-lock
    ];
  };
}
