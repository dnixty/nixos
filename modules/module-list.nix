{ pkgs, lib, ... }:

{
  imports = [
    ./profiles/base.nix
    ./profiles/bitcoin.nix
    ./profiles/bitlbee.nix
    ./profiles/desktop.nix
    ./profiles/git.nix
    ./profiles/i18n.nix
    ./profiles/laptop.nix
    ./profiles/nitrokey.nix
    ./profiles/audio.nix
    ./profiles/openssh.nix
    ./profiles/nix-auto-update.nix
    ./profiles/nix-config.nix
    ./profiles/ssd.nix
    ./profiles/tor.nix
    ./profiles/users.nix
    ./profiles/vpn.nix
    ./profiles/zsh.nix
  ];
}
