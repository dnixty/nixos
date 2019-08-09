{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.openssh;
in
{
  options = {
    profiles.openssh = {
      enable = mkOption {
        default = false;
        description = "Enable openssh profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };
}
