{ pkgs, ... }:

{
  profiles = {
    laptop.enable = true;
  };
  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelParams = [ "intel_idle.max_cstate=1" ];
  };
  hardware = {
    trackpoint = {
      enable = true;
      emulateWheel = true;
      sensitivity = 215;
      speed = 150;
    };
    cpu.intel.updateMicrocode = true;
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
}
