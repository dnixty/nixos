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
    initrd.luks.devices = {
      crypt-lvm = {
        device = "/dev/disk/by-uuid/fbbd0ea1-9839-477b-a47d-0fbe5de5d270";
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
    autologin-tty1.enable = true;
    bluetooth.enable = true;
    desktop.enable = true;
    git.enable = true;
    nas.enable = true;
    printing.enable = true;
    tor.enable = true;
    wireguard.enable = true;
  };
}
