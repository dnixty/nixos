{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
  shared = import ../shared.nix;
in
{
  imports = [
    ../hardware/librem13.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/nvme0n1";
    };
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/nvme0n1p2";
        preLVM = true;
      }
    ];
    cleanTmpDir = true;
  };

  time.timeZone = "Europe/London";

  networking = {
    extraHosts = shared.extraHosts;
    nat = {
      enable = true;
      externalInterface = "wlp2s0";
      internalInterfaces = [ "wg0" ];
    };
    firewall = {
      allowedUDPPorts = [ shared.ports.wireguard ];
      extraCommands = ''
        iptables -t nat -A POSTROUTING -s 10.206.94.0/24 -o wlp2s0 -j MASQUERADE
      '';
    };
    wireguard.interfaces = {
      wg0 = {
        ips = shared.wireguard.interfaces.heimdall.ips;
        listenPort = shared.ports.wireguard;
        privateKey = secrets.wireguard.privateKeys.heimdall;
        peers = [
          shared.wireguard.peers.njord
          shared.wireguard.peers.hel
        ];
      };
    };
  };

  profiles = {
    bitlbee.enable = true;
    git.enable = true;
    nitrokey.enable = true;
    tor.enable = true;
    vpn.enable = true;
    zsh.enable = true;
    nix-config.buildCores = 4;
  };

  # NFS resources
  fileSystems."/mnt/archive" = {
    device = "${shared.hosts.asgard}:/volume1/archive";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };
}
