{ config, pkgs, ... }:

{
  imports = [
    ../profiles/anki.nix
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

  networking.hostName = "heimdall";
  networking.networkmanager.enable = true;

  powerManagement.enable = true;

  hardware.bluetooth.enable = true;
  hardware.nitrokey.enable = true;

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    horizTwoFingerScroll = true;
    scrollDelta = -80;
    palmDetect = true;
    palmMinWidth = 4;
    palmMinZ = 50;
    minSpeed = "0.5";
    maxSpeed = "1.0";
    accelFactor = "0.075";
    additionalOptions = ''
      Option "MaxTapTime" "125"
      Option "SoftButtonAreas" "93% 0 95% 0 0 0 0 0"
    '';
  };

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;
}
