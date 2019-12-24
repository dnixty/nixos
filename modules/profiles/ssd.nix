{ config, lib, ... }:

with lib;
let
  cfg = config.profiles.ssd;
in
{
  options = {
    profiles.ssd = {
      enable = mkEnableOption "Enable ssd profile";
    };
  };
  config = mkIf cfg.enable {
    boot.kernel.sysctl = {
      "vm.swappiness" = lib.mkDefault 1;
    };
    services.fstrim.enable = lib.mkDefault true;
  };
}
