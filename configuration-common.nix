{ config, lib, pkgs, ... }:
with lib;

let secrets = import ./secrets.nix;
in
rec {
  imports = [
    # Import default packages.
    ./profiles/default.nix

    # Import default services.
    ./services/default.nix

    # Create user accounts
    ./users/dnixty.nix
  ];

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  boot = {
    # See console messages during early boot.
    initrd.kernelModules = [ "fbcon" ];

    # Disable console blanking after being idle.
    kernelParams = [ "consoleblank=0" ];

    # Clean /tmp on boot
    cleanTmpDir = true;
  };

  # /etc/hosts
  networking.extraHosts = secrets.extraHosts;

  # Select internationalisation properties
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Automatic gc
  #nix.gc.automatic = true;
  #nix.gc.dates = "weekly";
  #nix.gc.options = "--delete-older-than 30d";

  # Disable displaying the NixOS manual in a virtual console.
  #services.nixosManual = false;

  # Disable the infamous systemd screen/tmux kiler
  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

  # Increase the amount of inotify watchers
  # Note that inotify watches consume 1kB on 64-bit machines.
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;  # default:  8192
    "fs.inotify.max_user_instances" =    1024;  # default:   128
    "fs.inotify.max_queued_events"  =   32768;  # default: 16384
  };

  # Locate will update its database everyday at lunch time
  services.locate.enable = true;
  services.locate.interval = "00 12 * * *";
}
