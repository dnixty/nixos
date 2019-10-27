{ config, lib, pkgs, ... }:

{
  profiles = {
    laptop.enable = true;
    ssd.enable = true;
  };

  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "tp_smapi" ];
    extraModulePackages = with config.boot.kernelPackages; [ tp_smapi ];
    kernelParams = [
      "i915.enable_rc6=7"
    ];
  };
  hardware = {
    trackpoint = {
      enable = true;
      emulateWheel = true;
    };
    cpu.intel.updateMicrocode = true;
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.systemPackages = with pkgs; [
    linuxPackages.tp_smapi
  ];
}
