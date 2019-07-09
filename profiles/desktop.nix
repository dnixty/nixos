{ config, lib, pkgs, ... }:

let emacs = import ../pkgs/emacs/config.nix { inherit pkgs; };
in {
  imports = [
    ./emacs.nix
  ];

  # Configure basic X-server stuff:
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:ctrl_modifier";
    exportConfiguration = true;
    enableCtrlAltBackspace = true;

    # Give EXWM permission to control the session.
    displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localhost:$USER";

    # Use the pre 18.09 default display manager (slim)
    displayManager.slim.enable = true;
  };

  # Configure desktop environment:
  services.xserver.windowManager.session = lib.singleton {
    name = "exwm";
    start = ''
      ${emacs}/bin/emacs --daemon --eval "(require 'exwm)" -f exwm-enable; exec emacsclient -c
    '';
  };

  # nixpkgs.config = {
  #   chromium = {
  #     jre = false;
  #     enableGoogleTalkPlugin = true;
  #     enableAdobeFlash = false;
  #   };

  #   firefox = {
  #     jre = false;
  #     enableGoogleTalkPlugin = true;
  #     enableAdobeFlash = false;
  #   };
  # };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
      terminus_font
    ];
  };

  environment.systemPackages = with pkgs; [
    xorg.xrdb
    xorg.setxkbmap
    xorg.xset
    xorg.xsetroot
    xorg.xinput
    xorg.xprop
    xorg.xauth
    xorg.xmodmap
    xorg.xbacklight
    xorg.xkbcomp
    xcape
    xbindkeys
    xautolock
    xss-lock
    xdg_utils
    xfontsel
    xterm
    conky
    dzen2
    pinentry_emacs
    imagemagick
    chromium
    firefox

    # Unfree
    slack
    zoom-us
  ];
}
