{ pkgs, ... }:

{
  profiles = {
    laptop.enable = true;
    ssd.enable = true;
  };
  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelParams = [ "intel_idle.max_cstate=1" ];
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
