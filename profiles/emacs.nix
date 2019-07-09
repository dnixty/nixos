{ config, lib, pkgs, ... }:

{
  # Configure emacs.
  services.emacs = {
    install = true;
    defaultEditor = true;
    package = import ../pkgs/emacs/config.nix { inherit pkgs; };
  };
}
