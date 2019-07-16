{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/vim/config.nix
  ];

  environment.systemPackages = with pkgs; [
    curl
    git
    gnupg
    openssl
    stow
    vim_configurable
    wget
  ];
}
