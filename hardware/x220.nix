{ config, lib, pkgs, ... }:

{
  profiles = {
    laptop.enable = true;
    ssd.enable = true;
  };

  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "tp_smapi" "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ tp_smapi acpi_call ];
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
}
