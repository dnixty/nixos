{ config, lib, ... }:

with lib;
let
  cfg = config.profiles.ssd;
in
{
  options = {
    profiles.ssd = {
      enable = mkOption {
        default = false;
        description = "Enable ssd profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    boot.kernel.sysctl = {
      "vm.swappiness" = lib.mkDefault 1;
    };

    services.fstrim.enable = lib.mkDefault true;
  };
}
