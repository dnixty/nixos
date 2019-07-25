{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.users;
  secrets = import ../../secrets.nix;
in
{
  options = {
    profiles.users = {
      enable = mkOption {
        default = true;
        description = "Enable users profile";
        type = types.bool;
      };
      user = mkOption {
        default = "${secrets.username}";
        description = "Username to use when creating user";
        type = types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    users = {
      extraUsers = {
        ${cfg.user} = {
          isNormalUser = true;
          uid = 1000;
          createHome = true;
          group = "users";
          home = "/home/${secrets.username}";
          extraGroups = [ "wheel" "input" ] ++ optionals config.profiles.desktop.enable ["audio" "video" "lp" "networkmanager"]
            ++ optionals config.profiles.nitrokey.enable [ "nitrokey" ];
        };
      };
    };
    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
