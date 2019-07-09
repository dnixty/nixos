# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOs manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration-common.nix
      ./machines/heimdall.nix
    ];


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
