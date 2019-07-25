{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.nitrokey;
in
{
  options = {
    profiles.nitrokey = {
      enable = mkOption {
        default = false;
        description = "Enable yubikey profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    hardware.nitrokey.enable = true;
    environment.systemPackages = with pkgs; [
      nitrokey-udev-rules
    ];
  };
}
