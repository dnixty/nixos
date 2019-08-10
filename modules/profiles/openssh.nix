{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.openssh;
  secrets = import ../../secrets.nix;
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
      passwordAuthentication = false;
      permitRootLogin = "no";
      ports = [ secrets.ssh.port ];
    };
  };
}
