{ ... }:

{
  imports = [
    ./profiles/audio.nix
    ./profiles/base.nix
    ./profiles/bluetooth.nix
    ./profiles/desktop.nix
    ./profiles/git.nix
    ./profiles/laptop.nix
    ./profiles/nitrokey.nix
    ./profiles/nix-auto-update.nix
    ./profiles/nix-config.nix
    ./profiles/openvpn.nix
    ./profiles/ssd.nix
    ./profiles/tor.nix
    ./profiles/users.nix
    ./profiles/wireguard.nix
    ./profiles/zsh.nix
    ./services/autologin-tty1.nix
    ./services/bitcoind.nix
    ./services/bitlbee.nix
    ./services/nas.nix
    ./services/openssh.nix
    ./services/printing.nix
    ./services/xmpp.nix
  ];
}
