{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.audio;
in
{
  options = {
    profiles.audio = {
      enable = mkOption {
        default = false;
        description = "Enable audio profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    # hardware = {
    #   pulseaudio = {
    #     enable = true;
    #     package = pkgs.pulseaudioFull;
    #   };
    # };
    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
  };
}
