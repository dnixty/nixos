{ config, lib, ... }:

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
    i18n = {
      consoleFont = "Lat2-Terminus16";
      defaultLocale = "en_GB.UTF-8";
      consoleUseXkbConfig = true;
    };
    services.locate.enable = true;
    services.locate.interval = "00 12 * * *";
  };
}
