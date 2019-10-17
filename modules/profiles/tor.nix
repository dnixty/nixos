{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.tor;
in
{
  options = {
    profiles.tor = {
      enable = mkOption {
        default = false;
        description = "Enable tor profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    services.tor = {
      enable = true;
      client.enable = true;
    };
  };
}
