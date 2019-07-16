{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/vim/config.nix
  ];

  environment.systemPackages = with pkgs; [
    curl
    git
    gnupg

    gnumake
    autogen
    autoconf
    automake


    openssl
    stow
    vim_configurable
    wget
  ];
}
