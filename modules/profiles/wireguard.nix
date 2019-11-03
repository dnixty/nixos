{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.wireguard;
  secrets = import ../../secrets.nix;
  shared = import ../../shared.nix;
in
{
  options = {
    profiles.wireguard = {
      enable = mkOption {
        default = false;
        description = "Enable wireguard profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
    environment.systemPackages = with pkgs; [
      wireguard
    ];
  };
}
