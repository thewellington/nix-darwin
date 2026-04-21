
{ config, lib, pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    vim
    mkalias
    #
    # gui apps
    # arq # does not work yet 2026-04
    bartender
    # bbedit #dies not work yet 2026-04-12
    brave
    discord
    liquidprompt
    mas
    iterm2
    zed-editor
    zoom-us
    #
    # cli apps
    cowsay
    gpp
    nmap

  ];
}
