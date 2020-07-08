{ ... }:

{
  imports = [
    ./profiles/audio.nix
    ./profiles/base.nix
    ./profiles/bluetooth.nix
    ./profiles/desktop.nix
    ./profiles/git.nix
    ./profiles/laptop.nix
    ./profiles/nix-config.nix
    ./profiles/tor.nix
    ./profiles/users.nix
    ./services/autologin-tty1.nix
    ./services/bitcoind.nix
    ./services/nas.nix
    ./services/openssh.nix
    ./services/printing.nix
    ./services/wireguard.nix
  ];
}
