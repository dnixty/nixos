{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
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
        name = "root";
        device = "/dev/sda2";
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
    bitlbee.enable = true;
    git.enable = true;
    laptop.enable = true;
    nitrokey.enable = true;
    tor.enable = true;
    vpn.enable = true;
    zsh.enable = true;
    nix-config.buildCores = 4;
  };

  # NFS resources
  fileSystems."/mnt/archive" = {
    device = "${secrets.hosts.asgard}:/volume1/archive";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };
}
