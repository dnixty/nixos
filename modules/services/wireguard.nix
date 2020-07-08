{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.wireguard;
in
{
  options = {
    profiles.wireguard = {
      enable = mkEnableOption "Enable wireguard profile";
    };
  };
  config = mkIf cfg.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
    environment.systemPackages = with pkgs; [
      wireguard
    ];
  };
}
