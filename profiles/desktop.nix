{ config, lib, pkgs, ... }:

let secrets = import ../secrets.nix;
    emacs = import ../pkgs/emacs/config.nix { inherit pkgs; };
    keyboardLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp -I${../misc/xkb} ${../misc/xkb/usim.xkb} $out
    '';
in {
  imports = [
    ./emacs.nix
  ];

  # Configure basic X-server stuff:
  services.xserver = {
    enable = true;
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    exportConfiguration = true;

    # Give EXWM permission to control the session.
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xhost}/bin/xhost +SI:localhost:$USER
      ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${keyboardLayout} $DISPLAY
      ${pkgs.xss-lock}/bin/xss-lock slock &
    '';

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

  # Overwrite setuid wrappers
  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";

  environment.systemPackages = with pkgs; [
    conky
    dzen2
    slim
    slock
    xdg_utils
    xfontsel
    xorg.setxkbmap
    xorg.xkbcomp
    xorg.xrdb
    xorg.xset
    xss-lock
    xterm
  ];
}
