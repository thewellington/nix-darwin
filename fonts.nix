{ config, lib, pkgs, ...}: {

  fonts.packages = with pkgs; [
    nerdfonts
    source-code-pro
    source-sans-pro
    source-serif-pro
  ];
}
