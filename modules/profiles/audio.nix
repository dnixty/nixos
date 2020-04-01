{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.audio;
in
{
  options = {
    profiles.audio = {
      enable = mkEnableOption "Enable audio profile";
    };
  };
  config = mkIf cfg.enable {
    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
  };
}
