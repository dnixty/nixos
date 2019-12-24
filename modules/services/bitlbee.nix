{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.bitlbee;
in
{
  options = {
    profiles.bitlbee = {
      enable = mkEnableOption "Enable bitlbee profile";
    };
  };
  config = mkIf cfg.enable {
    services.bitlbee = {
      enable = true;
      libpurple_plugins = [ pkgs.purple-matrix ];
    };
  };
}
