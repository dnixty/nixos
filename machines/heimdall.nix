{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
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
    hosts = {
      "${secrets.hosts.asgard}" = [ "asgard" ];
      "${secrets.hosts.niflheim}" = [ "niflheim" ];
      "${secrets.hosts.midgard}" = [ "midgard" ];
    };
  };

  profiles = {
    git.enable = true;
    laptop.enable = true;
    nitrokey.enable = true;
    vpn.enable = true;
    nix-config.buildCores = 4;
  };

  # NFS resources
  fileSystems."/mnt/archive" = {
    device = "${secrets.hosts.asgard}:/volume1/archive";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };
}
