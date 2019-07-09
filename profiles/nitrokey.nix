{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nitrokey-udev-rules
  ];
}
