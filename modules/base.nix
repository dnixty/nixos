{ config, pkgs, ... }:
let
  shared = import ../shared.nix;
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
  environment.systemPackages = with pkgs; [
    wireguard
  ];
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  i18n.defaultLocale = "en_GB.UTF-8";
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  users = {
    extraUsers = {
      ${shared.user.username} = {
        isNormalUser = true;
        uid = 1000;
        createHome = true;
        group = "users";
        home = "/home/${shared.user.username}";
        extraGroups = [ "wheel" "input" "audio" "video" "lp" "networkmanager"];
        openssh.authorizedKeys.keys = shared.ssh_keys;
      };
    };
  };
}
