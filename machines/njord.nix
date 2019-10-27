{ config, pkgs, lib, ... }:

with lib;
let
  secrets = import ../secrets.nix;
in
{
  boot = {
    kernel = {
      sysctl."vm.overcommit_memory" = "1";
    };

    loader = {
      grub.device = "/dev/vda";
      grub.enable = true;
      grub.version = 2;
    };
    cleanTmpDir = true;
  };

  profiles = {
    openssh.enable = true;
    git.enable = true;
  };

  environment = {
    variables = {
      EDITOR = "vim";
    };
  };
}
