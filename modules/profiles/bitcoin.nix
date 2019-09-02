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
    networking.firewall.allowedTCPPorts = [ 8332 18332 ];
    environment.systemPackages = with pkgs; [
      unstable.bitcoind
    ];
    systemd.services.bitcoind = {
      enable = cfg.autostart;
      description = "Bitcoin daemon";
      serviceConfig = {
        ExecStartPre="/bin/sh -c 'sleep 30'";
        ExecStart = "${pkgs.unstable.bitcoind}/bin/bitcoind -daemon -datadir=${cfg.configDir} -pid=${cfg.configDir}/bitcoind.pid";
        PIDFile="${cfg.configDir}/bitcoind.pid";
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
