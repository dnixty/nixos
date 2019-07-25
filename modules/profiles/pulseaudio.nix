{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.pulseaudio;
in
{
  options = {
    profiles.pulseaudio = {
      enable = mkOption {
        default = false;
        description = "Enable pulseaudio profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    hardware = {
      pulseaudio = {
        enable = true;
        package = pkgs.pulseaudioFull;
      };
    };
    sound.mediaKeys.enable = true;
  };
}
