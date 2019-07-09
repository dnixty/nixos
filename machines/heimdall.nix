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

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;
}
