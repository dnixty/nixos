{ ... }:
let
  secrets = import ../secrets.nix;
  shared = import ../shared.nix;
in
{
  imports = [
    ../hardware/x220.nix
  ];
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    initrd.luks.devices = [
      {
        name = "crypt-lvm";
        device = "/dev/sda2";
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
        ips = shared.wireguard.interfaces.tyr.ips;
        listenPort = shared.ports.wireguard;
        privateKey = secrets.wireguard.privateKeys.tyr;
        peers = [
          shared.wireguard.peers.njord
          shared.wireguard.peers.hel
        ];
      };
    };
  };
  profiles = {
    git.enable = true;
    tor.enable = true;
    openvpn.enable = true;
    wireguard.enable = true;
    nix-config.buildCores = 4;
  };
  fileSystems."/mnt/archive" = {
    device = "odin:/volume1/archive";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };
}
