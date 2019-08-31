{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.bitcoin;
in
{
  options = {
    profiles.bitcoin = {
      enable = mkOption {
        default = false;
        description = "Enable bitcoin profile";
        type = types.bool;
      };
      autostart = mkOption {
        default = true;
        description = "Autostart bitcoind on boot";
        type = types.bool;
      };
      configDir = mkOption {
        default = "/mnt/bitcoin";
        description = "Bitcoin data location";
        type = types.string;
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      altcoins.bitcoind
    ];
    systemd.user.services.bitcoind = {
      enable = cfg.autostart;
      description = "Bitcoin daemon";
      serviceConfig = {
        ExecStartPre="/bin/sh -c 'sleep 30'";
        ExecStart = "${pkgs.altcoins.bitcoind}/bin/bitcoind -daemon -conf=${cfg.configDir}/bitcoin.conf -pid=${cfg.configDir}/bitcoin.pid";
        PIDFile="${cfg.configDir}/bitcoin.pid";
        Type = "forking";
        KillMode = "process";
        Restart = "always";
        TimeoutSec = 120;
        RestartSec = 30;
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
