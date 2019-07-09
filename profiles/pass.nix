{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pass
    passExtensions.pass-otp
  ];
}
