
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
    
    iterm2
    mas
    zed-editor
    zoom-us
    #
    # cli apps
    aws-cli
    azure-cli
    cowsay
    gpp
    nmap
    netlify-cli
    


  ];
}
