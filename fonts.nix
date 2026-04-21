{ config, lib, pkgs, ...}: {

  fonts.packages = with pkgs; [

    source-code-pro
    source-sans-pro
    source-serif-pro
  ];
}
