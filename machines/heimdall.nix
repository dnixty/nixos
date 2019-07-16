{ config, pkgs, ... }:

{
   imports = [
    ../profiles/audio.nix
    ../profiles/desktop.nix
    ../profiles/nitrokey.nix
    ../profiles/pass.nix
    ../profiles/redshift.nix
  ];

  # Speed up development at the cost of possible build race conditions
  nix.buildCores = 4;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/nvme0n1";

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
    }
  ];

  boot.extraModprobeConfig = ''
    options resume=/dev/nixos-vg/swap
  '';

  networking = {
    hostName = "heimdall";
    networkmanager.enable = true;
  };

  powerManagement.enable = true;

  hardware.bluetooth.enable = true;
  hardware.nitrokey.enable = true;

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    horizTwoFingerScroll = true;
    tapButtons = false;
    scrollDelta = -80;
    minSpeed = "0.5";
    maxSpeed = "1.0";
    accelFactor = "0.075";
  };

  # Additional key bindings
  programs.light.enable = true;

  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  boot.postBootCommands = ''
    mkdir -p /mnt/archive
  '';

  # NFS resources
  fileSystems."/mnt/archive" = {
    device = "asgard:/volume1/archive";
    fsType = "nfs";
    options = ["rw" "async" "noauto" "_netdev"];
  };
}
