{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.desktop;
  shared = import ../../shared.nix;
  my-slock = pkgs.slock.override { conf = builtins.readFile ../../assets/slock/config.def.h; };
in
{
  options = {
    profiles.desktop = {
      enable = mkOption {
        default = false;
        description = "Enable desktop profile";
        type = types.bool;
      };
      audio = mkOption {
        default = true;
        description = "Enable audio with desktop profile";
        type = types.bool;
      };
      networkmanager = mkOption {
        default = true;
        description = "Enable networkmanager with desktop profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    profiles.audio.enable = cfg.audio;
    networking.networkmanager = {
      enable = cfg.networkmanager;
    };
    services.xserver = {
      enable = true;
      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
      xkbOptions = "ctrl:swapcaps";
      displayManager = {
        sessionCommands = ''
          ${pkgs.xss-lock}/bin/xss-lock slock &
        '';
        auto = {
          enable = true;
          user = shared.user.username;
        };
      };
    };
    security.wrappers.slock.source = "${my-slock.out}/bin/slock";
    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        inconsolata
      ];
    };
    environment.systemPackages = with pkgs; [
      xss-lock
      my-slock
    ];
  };
}
