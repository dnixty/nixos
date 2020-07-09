{ ... }:
let
  secrets = import ./secrets.nix;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/base.nix
      (./machines + "/${secrets.hostname}.nix")
    ];
  networking.hostName = "${secrets.hostname}";
}
