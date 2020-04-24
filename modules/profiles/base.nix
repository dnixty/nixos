{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.base;
in
{
  options = {
    profiles.base = {
      enable = mkOption {
        default = true;
        description = "Enable base profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
    };
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };
    i18n.defaultLocale = "en_GB.UTF-8";
    services.locate.enable = true;
    services.locate.interval = "00 12 * * *";
  };
}
