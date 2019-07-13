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

  # Gnupg
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # Environment
  environment = {
    variables = {
      # Set $TMPDIR so that it is the same inside and outside Nix shells.
      TMPDIR = "/var/run/user/$UID";
    };
  };
}
