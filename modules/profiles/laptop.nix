{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.laptop;
in
{
  options = {
    profiles.laptop = {
      enable = mkOption {
        default = false;
        description = "Enable laptop profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    profiles.desktop.enable = true;

    boot = {
      kernelModules = [ "acpi_call" ];
      extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    };

    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkIf config.services.tlp.enable (lib.mkForce null);
    };
    services.tlp.enable = true;
  };
}
