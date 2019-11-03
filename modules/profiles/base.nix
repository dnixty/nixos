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
    i18n = {
      defaultLocale = "en_GB.UTF-8";
    };
    # Move to profiles/cron?
    services.locate.enable = true;
    services.locate.interval = "00 12 * * *";

    environment.systemPackages = with pkgs; [
      vim
    ];
  };
}
