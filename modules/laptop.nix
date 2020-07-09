{ config, pkgs, ... }:
{
  imports = [
    ./autologin-tty1.nix
  ];
  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];
  };
  console.useXkbConfig = true;
  environment.systemPackages = with pkgs; [
    xss-lock
  ];
  fileSystems = {
    "/mnt/archive" = {
      device = "odin:/volume1/archive";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
    "/mnt/torrents" = {
      device = "odin:/volume1/torrents";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };
  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ hack-font ];
  };
  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };
  networking.networkmanager.enable = true;
  powerManagement = {
    enable = true;
  };
  programs.slock.enable = true;
  services = {
    acpid.enable = true;
    fstrim.enable = true;
    tlp.enable = true;
    blueman.enable = true;
    picom = {
      enable = true;
      fade = true;
      fadeDelta = 4;
      inactiveOpacity = "0.9";
      shadow = true;
    };
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    tor = {
      enable = true;
      client.enable = true;
    };
    xserver = {
      enable = true;
      xkbOptions = "ctrl:swapcaps";
      desktopManager.xfce.enable = true;
      displayManager.startx.enable = true;
    };
  };
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
}
