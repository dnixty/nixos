{ pkgs, lib, ... }:

{
  imports = [
    ./profiles/base.nix
    ./profiles/desktop.nix
    ./profiles/git.nix
    ./profiles/i18n.nix
    ./profiles/laptop.nix
    ./profiles/nitrokey.nix
    ./profiles/pulseaudio.nix
    ./profiles/nix-auto-update.nix
    ./profiles/nix-config.nix
    ./profiles/users.nix
    ./profiles/vpn.nix
  ];
}
