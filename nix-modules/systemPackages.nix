
{ config, lib, pkgs, ...}: {

  environment.systemPackages = with pkgs; [

    # gui apps
    # arq # does not work yet 2026-04
    # Rbartender # pulling becuase Bartender is buggy af in version 6
    # bbedit #dies not work yet 2026-04-12
    brave
    # discord
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
