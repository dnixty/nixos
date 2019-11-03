{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.prosody;
in
{
  options = {
    profiles.prosody = {
      enable = mkOption {
        default = false;
        description = "Enable prosody profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    services.prosody = {
      enable = true;
    };
  };
}
