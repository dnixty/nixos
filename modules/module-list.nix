{ pkgs, lib, ... }:

{
  imports = [
    ./profiles/audio.nix
    ./profiles/base.nix
    ./profiles/bitcoin.nix
    ./profiles/bitlbee.nix
    ./profiles/desktop.nix
    ./profiles/git.nix
    ./profiles/i18n.nix
    ./profiles/laptop.nix
    ./profiles/nitrokey.nix
    ./profiles/nix-auto-update.nix
    ./profiles/nix-config.nix
    ./profiles/openssh.nix
    ./profiles/prosody.nix
    ./profiles/ssd.nix
    ./profiles/tor.nix
    ./profiles/users.nix
    ./profiles/vpn.nix
    ./profiles/wireguard.nix
    ./profiles/zsh.nix
  ];
}
