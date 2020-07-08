{ config, lib, ... }:

with lib;
let
  cfg = config.profiles.laptop;
in
{
  options = {
    profiles.laptop = {
      enable = mkEnableOption "Enable laptop profile";
    };
  };
  config = mkIf cfg.enable {
    boot = {
      kernelModules = [ "acpi_call" ];
      extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    };
    powerManagement = {
      enable = true;
    };
    services = {
      tlp.enable = true;
      acpid.enable = true;
      fstrim.enable = true;
    };
  };
}
