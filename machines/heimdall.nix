{ config, pkgs, ... }:

let shared = import ../shared.nix;
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
      "${shared.hosts.njord}" = [ "njord" ];
      "${shared.hosts.asgard}" = [ "asgard" ];
      "${shared.hosts.niflheim}" = [ "niflheim" ];
      "${shared.hosts.midgard}" = [ "midgard" ];
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
