
{ config, lib, pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    vim
    iterm2
    bartender
    mkalias
    zed-editor
    cowsay
    gpp
    nmap
  ];
}
