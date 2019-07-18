{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
in
{
 #  networking.nat = {
 #    enable = true;
 #    externalInterface = "wlp1s0";
 #    internalInterfaces = [ "wg0" ];
 #  };

 #  networking.wireguard.interfaces.wg0 = {
 #    ips = [ "10.99.56.152/32" "fc00:bbbb:bbbb:bb01::3898/128" ];
 #    privateKey = secrets.mullvad.wireguard.privateKey;
 #    peers = [{
 #      allowedIPs = [ "0.0.0.0/0" "::/0" ];
 #      publicKey = "TMOEAxpcv5xz+PvcvqP0Iy4+px+hrCJUJHGcy45DVQI=";
 #      endpoint = "185.200.118.100:51820";
 #    }];
 #  };

 #  boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

 # environment.systemPackages = with pkgs; [
 #   wireguard
 #   wireguard-tools
 # ];
  services.openvpn.servers = {
    mullvad = {
      config = ''
        config /home/dnixty/vpn/mullvad_gb.conf
      '';
      autoStart = true;
      updateResolvConf = true;
    };
  };
}
