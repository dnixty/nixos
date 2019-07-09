{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    dtach
    gnupg
    openssl
    sudo
    unzip
    w3m
    stow
    wget
    youtube-dl
    zip
    git
    vim
  ];
}
