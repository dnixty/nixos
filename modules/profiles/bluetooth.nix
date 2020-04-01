{ config, lib, ... }:

with lib;
let
  cfg = config.profiles.bluetooth;
in
{
  options = {
    profiles.bluetooth = {
      enable = mkEnableOption "Enable bluetooth profile";
    };
  };
  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
