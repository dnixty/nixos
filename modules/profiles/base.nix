{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.base;
  shared = import ../../shared.nix;
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
    systemd = {
      targets."autologin-tty1" = {
        description = "Final";
        requires = [ "multi-user.target" ];
        after = [ "multi-user.target" ];
        unitConfig = { AllowIsolate = "yes"; };
      };
      services = {
        "supress-kernel-logging" = {
          description = "Suppress kernel logging to the console";
          after = [ "multi-user.target" ];
          wantedBy = [ "autologin-tty1.target" ];
          serviceConfig = {
            ExecStart = [
              "${pkgs.utillinux}/sbin/dmesg -n 1"
            ];
            Type = "oneshot";
          };
        };
        "autovt@tty1" = {
          description = "Autologin on TTY1";
          after = [ "suppress-kernel-logging.service" ];
          wantedBy = [ "autologin-tty1.target" ];
          restartIfChanged = false;
          serviceConfig = {
            ExecStart = [
              "" # override upstream default with an empty ExecStart
              "@${pkgs.utillinux}/sbin/agetty agetty --login-program ${pkgs.shadow}/bin/login --autologin ${shared.user.username} --noclear %I $TERM"
            ];
            Restart = "always";
            Type = "idle";
          };
        };
      };
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
