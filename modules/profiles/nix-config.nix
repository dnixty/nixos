{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.nix-config;
in
{
  options = {
    profiles.nix-config = {
      enable = mkOption {
        default = true;
        description = "Enable nix-config profile";
        type = types.bool;
      };
      gcDates = mkOption {
        default = "weekly";
        description = "Specification (in the format described by systemd.time(7)) of the time at which the garbage collector will run.";
        type = types.str;
      };
      olderThan = mkOption {
        default = "15d";
        description = "Number of days to keep garbage";
        type = types.str;
      };
      buildCores = mkOption {
        type = types.int;
        default = 2;
        example = 4;
        description = ''
          Maximum number of concurrent tasks during one build.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    nix = {
      buildCores = cfg.buildCores;
      useSandbox = true;
      gc = {
        automatic = true;
        dates = cfg.gcDates;
        options = "--delete-older-than ${cfg.olderThan}";
      };
      # if hydra is down, don't wait forever
      extraOptions = ''
        connect-timeout = 20
        build-cores = 0
      '';
    };
  };
}
