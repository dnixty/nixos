{ config, lib, ... }:

with lib;
let
  cfg = config.profiles.zsh;
in
{
  options = {
    profiles.zsh = {
      enable = mkEnableOption "Enable zsh profile";
    };
  };
  config = mkIf cfg.enable {
    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ];
  };
}
