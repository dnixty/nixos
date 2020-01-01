{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.openvpn;
in
{
  options = {
    profiles.openvpn = {
      enable = mkEnableOption "Enable openvpn profile";
    };
  };
  config = mkIf cfg.enable {
    networking.networkmanager = {
      packages = with pkgs; [ networkmanager-openvpn ];
    };
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
