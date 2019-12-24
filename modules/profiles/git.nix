{ config, lib, pkgs, ... }:

with lib;
let
  shared = import ../../shared.nix;
  cfg = config.profiles.git;
in
{
  options = {
    profiles.git = {
      enable = mkEnableOption "Enable git profile";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
    ];
    environment.etc."gitconfig" = rec {
      text = ''
  [alias]
    co = checkout
    st = status
    ci = commit --signoff
    ca = commit --amend
    b = branch --color -v
    br = branch
    unstage = reset HEAD
  [push]
    default = matching
  [user]
    name = ${shared.user.name}
    email = ${shared.user.email}
      '';
    };
  };
}
