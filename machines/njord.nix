{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
  shared = import ../shared.nix;
in
{
  boot = {
    kernel = {
      sysctl."vm.overcommit_memory" = "1";
    };

    loader = {
      grub.device = "/dev/vda";
      grub.enable = true;
      grub.version = 2;
    };
    cleanTmpDir = true;
  };

  profiles = {
    openssh.enable = true;
    git.enable = true;
    xmpp.enable = true;
    wireguard.enable = true;
  };

  environment = {
    variables = {
      EDITOR = "vim";
    };
  };
  networking = {
    extraHosts = shared.extraHosts;
    nat = {
      enable = true;
      externalInterface = "ens3";
      internalInterfaces = [ "wg0" ];
    };
    firewall = {
      allowedUDPPorts = [ shared.ports.wireguard ];
      extraCommands = ''
        iptables -t nat -A POSTROUTING -s 10.206.94.0/24 -o ens3 -j MASQUERADE
      '';
    };
    wireguard.interfaces = {
      wg0 = {
        ips = shared.wireguard.interfaces.njord.ips;
        listenPort = shared.ports.wireguard;
        privateKey = secrets.wireguard.privateKeys.njord;
        peers = [
          shared.wireguard.peers.tyr
          shared.wireguard.peers.heimdall
          shared.wireguard.peers.hel
        ];
      };
    };
  };
}
