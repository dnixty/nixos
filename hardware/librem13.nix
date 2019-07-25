{ config, pkgs, ... }:

{
  services = {
    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
        { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      ];
    };
    acpid.enable = true;

    xserver.synaptics = {
      enable = true;
      twoFingerScroll = true;
      horizTwoFingerScroll = true;
      tapButtons = false;
      scrollDelta = -80;
      minSpeed = "0.5";
      maxSpeed = "1.0";
      accelFactor = "0.075";
    };
  };

  programs.light.enable = true;

  powerManagement.enable = true;
}
