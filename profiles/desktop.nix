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
    displayManager.slim = {
      enable = true;
      defaultUser = "dnixty";
      theme = ../misc/slim-theme;
    };
  };

  # Configure desktop environment:
  services.xserver.windowManager.session = lib.singleton {
    name = "exwm";
    start = ''
      conky | dzen2 -p -dock -ta l -fn "DejaVu Sans Mono" &
      ${emacs}/bin/emacs --daemon --eval "(require 'exwm)" -f exwm-enable
      exec emacsclient -c
    '';
  };

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
    chromium
    conky
    dzen2
    firefox
    imagemagick
    pinentry_emacs
    xbindkeys
    xdg_utils
    xfontsel
    xorg.setxkbmap
    xorg.xbacklight
    xorg.xkbcomp
    xorg.xrdb
    xorg.xset
    xss-lock
    xterm

    # Unfree
    slack
    zoom-us
  ];
}
