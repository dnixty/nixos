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
}
