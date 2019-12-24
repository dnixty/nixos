{ config, lib, pkgs, ... }:

with lib;
let
  shared = import ../../shared.nix;
  cfg = config.profiles.bitcoind;
in
{
  options = {
    profiles.bitcoind = {
      enable = mkEnableOption "Enable bitcoind profile";
      autostart = mkOption {
        default = true;
        description = "Autostart bitcoind on boot";
        type = types.bool;
      };
      configDir = mkOption {
        default = "/mnt/bitcoin";
        description = "Bitcoin data location";
        type = types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    profiles.tor.enable = true;
    networking.firewall.allowedTCPPorts = [ 8332 18332 ];
    environment.systemPackages = with pkgs; [
      unstable.bitcoind
    ];
    systemd.services.bitcoind = {
      enable = cfg.autostart;
      description = "Bitcoin daemon";
      serviceConfig = {
        ExecStart = "${pkgs.unstable.bitcoind}/bin/bitcoind -daemon -datadir=${cfg.configDir} -conf=${cfg.configDir}/bitcoin.conf -pid=${cfg.configDir}/bitcoind.pid";
        PIDFile="${cfg.configDir}/bitcoind.pid";
        Type = "forking";
        KillMode = "process";
        Restart = "always";
        TimeoutSec = 120;
        RestartSec = 30;
      };
      wantedBy = [ "multi-user.target" ];
    };
    system.activationScripts = {
      bitcoinDir = ''
        ln -s ${cfg.configDir} /home/${shared.user.username}/.bitcoind
      '';
    };
  };
}
