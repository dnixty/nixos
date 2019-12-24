{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.xmpp;
in
{
  options = {
    profiles.xmpp = {
      enable = mkEnableOption "Enable xmpp service";
    };
  };
  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [5222 5269];
    services.nginx.virtualHosts."xmpp.dnixty.com" = {
      forceSSL = true;
      enableACME = true;
      locations."/".extraConfig = ''
        deny all;
        return 404;
      '';
    };
    security.acme.certs."xmpp.dnixty.com".postRun = concatStringsSep " && " [
      "${pkgs.coreutils}/bin/install -D -m 0700 -o prosody -g prosody /var/lib/acme/xmpp.dnixty.com/fullchain.pem /var/lib/prosody/tls.crt"
      "${pkgs.coreutils}/bin/install -D -m 0700 -o prosody -g prosody /var/lib/acme/xmpp.dnixty.com/key.pem /var/lib/prosody/tls.key"
      "systemctl restart prosody.service"
    ];
    services.prosody = {
      enable = true;
      modules = {
        mam = true;
        bosh = true;
      };
      admins = [ "admin@xmpp.dnixty.com" ];
      virtualHosts = {
        "xmpp.dnixty.com" = {
          doman = "xmpp.dnixty.com";
          enabled = true;
          ssl = {
            key = "/var/lib/prosody/tls.crt";
            cert = "/var/lib/prosody/tls.key";
          };
        };
      };
    };
  };
}
