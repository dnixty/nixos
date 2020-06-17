{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.nas;
in
{
  options = {
    profiles.nas = {
      enable = mkEnableOption "Enable nas profile";
    };
  };
  config = mkIf cfg.enable {
    fileSystems = {
      "/mnt/archive" = {
        device = "odin:/volume1/archive";
        fsType = "nfs";
        options = ["x-systemd.automount" "noauto"];
      };
      "/mnt/torrents" = {
        device = "odin:/volume1/torrents";
        fsType = "nfs";
        options = ["x-systemd.automount" "noauto"];
      };
    };
  };
}
