{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.xmpp;
in
{
  options = {
    profiles.xmpp = {
      enable = mkOption {
        default = false;
        description = "Enable xmpp profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    # networking.firewall.allowedTCPPorts = [5222 5269 5281 5280 5000];

    security.acme.certs."prosody-xmpp.dnixty.com" = {
      domain = "xmpp.dnixty.com";
      user = "root";
      group = "prosody";
      allowKeysForGroup = true;
      webroot = config.security.acme.certs."xmpp.dnixty.com".webroot;
      postRun = "systemctl restart prosody";
    };

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
            key = "/var/lib/acme/prosody-xmpp.dnixty.com/key.pem";
            cert = "/var/lib/acme/prosody-xmpp.dnixty.com/fullchain.pem";
          };
        };
      };
    };
  };
}
