{ config, pkgs, ... }:

{
  nixpkgs.config.vim = {
    ftNixSupport = true;
  };

  environment.interactiveShellInit = ''
    alias vi='vim'
  '';

  environment.variables = {
    EDITOR = [ "${pkgs.vim}/bin/vim" ];
  };

  environment.etc.vimrc = {
    text = ''
      set nocompatible
      set backspace=indent,eol,start
      set history=1024
      if has("syntax")
        syntax on
      endif
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set ruler
    '';
  };

  environment.systemPackages = [ pkgs.vim_configurable ];
}
