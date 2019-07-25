{ config, pkgs, ... }:

let secrets = import ./secrets.nix;
in
rec {
  imports =
    [
      # Generated hardware configuration
      ./hardware-configuration.nix
      # Default profile with default configuration
      ./modules/module-list.nix
      # Machine specific configuration files
      (./machines + "/${secrets.hostname}.nix")
    ];

  networking.hostName = "${secrets.hostname}";
}
