{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.bitlbee;
in
{
  options = {
    profiles.bitlbee = {
      enable = mkOption {
        default = false;
        description = "Enable bitlbee profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    services.bitlbee = {
      enable = true;
      libpurple_plugins = [ pkgs.purple-matrix ];
    };
  };
}
