{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.openssh;
  shared = import ../../shared.nix;
in
{
  options = {
    profiles.openssh = {
      enable = mkEnableOption "Enable openssh profile";
    };
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
      ports = [ shared.ports.sshd ];
    };
  };
}
