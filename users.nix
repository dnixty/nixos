{ config, lib, pkgs, ... }:
with lib;

let secrets = import ./secrets.nix;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${secrets.username} = {
    isNormalUser = true;
    group = "users";
    createHome = true;
    home = "/home/${secrets.username}";
    uid = 1000;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "nitrokey"
      "networkmanager"
    ];

  # openssh.authorizedKeys.keys = secret.sshKeys.yeah;
  };

  system.activationScripts =
  {
    # Configure dotfiles.
    dotfiles = stringAfter [ "users" ]
    ''
      cd /home/${secrets.username}
    '';
  };
}
