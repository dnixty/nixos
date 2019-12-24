{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.nitrokey;
in
{
  options = {
    profiles.nitrokey = {
      enable = mkEnableOption "Enable nitrokey profile";
    };
  };
  config = mkIf cfg.enable {
    hardware.nitrokey.enable = true;
    environment.systemPackages = with pkgs; [
      nitrokey-udev-rules
    ];
  };
}
