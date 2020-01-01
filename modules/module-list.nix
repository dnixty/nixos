{ ... }:

{
  imports = [
    ./profiles/audio.nix
    ./profiles/base.nix
    ./profiles/desktop.nix
    ./profiles/git.nix
    ./profiles/laptop.nix
    ./profiles/nitrokey.nix
    ./profiles/nix-auto-update.nix
    ./profiles/nix-config.nix
    ./profiles/ssd.nix
    ./profiles/tor.nix
    ./profiles/users.nix
    ./profiles/openvpn.nix
    ./profiles/wireguard.nix
    ./profiles/zsh.nix
    ./services/bitcoind.nix
    ./services/bitlbee.nix
    ./services/openssh.nix
    ./services/xmpp.nix
  ];
}
