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
      autoLogin = mkOption {
        default = false;
        description = "Enable auto login";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    profiles.pulseaudio.enable = cfg.pulseaudio;

    hardware.bluetooth.enable = true;

    networking.networkmanager = {
      enable = cfg.networkmanager;
      unmanaged = [
        "interface-name:wg0" "interface-name:docker0"
      ];
      packages = with pkgs; [ networkmanager-openvpn ];
    };
    services.xserver = {
      enable = true;
      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
      xkbOptions = "ctrl:swapcaps";

      displayManager = {
        # Give EXWM permission to control the session.
        sessionCommands = ''
          ${pkgs.xorg.xhost}/bin/xhost +SI:localhost:$USER
        '';

        slim = {
          enable = true;
          autoLogin = cfg.autoLogin;
          defaultUser = "${secrets.username}";
          theme = ./assets/slim-theme;
        };
      };
    };
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
    ];
  };
}
