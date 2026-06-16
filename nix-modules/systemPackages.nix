
{ config, lib, pkgs, ...}: {

  environment.systemPackages = with pkgs; [

    # gui apps
    # arq # does not work yet 2026-04
    bartender
    # bbedit #dies not work yet 2026-04-12
    brave
    # discord
    iterm2
    zed-editor
    zoom-us

 		# cli apps
    awscli2
    azure-cli
    cowsay
    exiftool
    gpp # resume
    mas # required by homebrew to install mas items
    mkalias
    netlify-cli
    nmap
    pandoc # resume
    vim #required for nix


  ];
}
