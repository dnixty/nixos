{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.desktop;
  secrets = import ../../secrets.nix;
in
{
  options = {
    profiles.desktop = {
      enable = mkOption {
        default = false;
        description = "Enable desktop profile";
        type = types.bool;
      };
      pulseaudio = mkOption {
        default = true;
        description = "Enable pulseaudio with desktop profile";
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
    profiles.pulseaudio.enable = cfg.pulseaudio;
    networking.networkmanager = {
      enable = cfg.networkmanager;
      packages = with pkgs; [ networkmanager-openvpn ];
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
          user = "${secrets.username}";
        };
      };
    };
    security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        dejavu_fonts
        inconsolata
        terminus_font
      ];
    };
    environment.systemPackages = with pkgs; [
      xss-lock
      slock
    ];
  };
}
