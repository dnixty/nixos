{ config, pkgs, lib, ... }:

with lib;
let
  secrets = import ../secrets.nix;
  shared = import ../shared.nix;
in
{
  imports = [
    ../hardware/raspberryPi3.nix
  ];

  networking.wireless.enable = true;
  networking.wireless.networks = {
    "${secrets.networks.skynet.ssid}".psk = "${secrets.networks.skynet.psk}";
  };
  services.fail2ban.enable = true;

  profiles = {
    git.enable = true;
    bitcoin.enable = true;
  };

  fileSystems = {
    "/mnt/bitcoin" = {
      device = "${shared.hosts.asgard}:/volume1/bitcoin";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };
}
