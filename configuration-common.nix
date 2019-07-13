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
    ./users.nix
  ];

  boot = {
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
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  # Locate will update its database everyday at lunch time
  services.locate.enable = true;
  services.locate.interval = "00 12 * * *";

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Additional key bindings
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 113 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"; }
      { keys = [ 114 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/pactl set-sink-volume @DEFAULT_SINK@ -2%"; }
      { keys = [ 115 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/pactl set-sink-volume @DEFAULT_SINK@ +2%"; }
    ];
  };
}
