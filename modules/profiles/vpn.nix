{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.vpn;
in
{
  options = {
    profiles.vpn = {
      enable = mkOption {
        default = false;
        description = "Enable vpn profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    services.openvpn.servers = {
      mullvad = {
        config = ''
          config /home/dnixty/vpn/mullvad_gb.conf
        '';
        autoStart = true;
        updateResolvConf = true;
      };
    };
  };
}
