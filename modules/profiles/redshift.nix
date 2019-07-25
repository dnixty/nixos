{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.redshift;
in
{
  options = {
    profiles.redshift = {
      enable = mkOption {
        default = false;
        description = "Enable redshift profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    services.redshift = {
      enable = true;
      latitude = "51.5094";
      longitude = "0.1365";
      temperature.night = 3000;
      brightness.night = "0.8";
    };
  };
}
