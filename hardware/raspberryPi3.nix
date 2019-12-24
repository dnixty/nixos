{ pkgs, ... }:

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
    kernelParams = ["cma=256M"];
    cleanTmpDir = true;
  };
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
  hardware.enableRedistributableFirmware = true;
  services.nixosManual.enable = false;
  profiles.openssh.enable = true;
  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];
}

