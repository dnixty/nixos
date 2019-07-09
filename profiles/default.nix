{ config, pkgs, ... }:

{
  imports = [
#    ../pkgs/emacs/config.nix
    ../pkgs/vim/config.nix
  ];

  environment.systemPackages = with pkgs; [
    curl
    git
    gnupg
    openssl
    stow
    unzip
    vim_configurable
    wget
    youtube-dl
  ];
}
