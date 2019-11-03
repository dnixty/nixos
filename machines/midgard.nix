{ config, pkgs, lib, ... }:

with lib;
let
  secrets = import ../secrets.nix;
  shared = import ../shared.nix;
in
{
  boot = {
    loader = {
      grub.enable = false;
      raspberryPi = {
        enable = true;
        version = 3;
        uboot.enable = true;
        firmwareConfig = ''
          gpu_mem=256
        '';
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["cma=32M"];
    cleanTmpDir = true;
  };

  hardware.enableRedistributableFirmware = true;

  services.nixosManual.enable = false;

  networking.wireless.enable = true;
  networking.wireless.networks = {
    "${secrets.networks.skynet.ssid}".psk = "${secrets.networks.skynet.psk}";
  };

  profiles = {
    openssh.enable = true;
    git.enable = true;
    bitcoin.enable = true;
  };

  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
    "/mnt/bitcoin" = {
      device = "${shared.hosts.asgard}:/volume1/bitcoin";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };

  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
