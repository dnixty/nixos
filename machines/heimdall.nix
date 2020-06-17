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
    initrd.luks.devices = {
      crypt-lvm = {
        device = "/dev/disk/by-uuid/c42fc2e8-d3d9-46f3-8262-c27131bca23e";
      };
    };
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
    bluetooth.enable = true;
    git.enable = true;
    tor.enable = true;
    openvpn.enable = true;
    wireguard.enable = true;
    printing.enable = true;
    autologin-tty1.enable = true;
    nas.enable = true;
    nix-config.buildCores = 4;
  };
}
