{ pkgs, ...}: {
  system.defaults = {
    dock.autohide = true;
    dock.magnification = true;
    dock.mineffect = "genie";
    dock.persistent-apps = [
      "${pkgs.zed-editor}/Applications/Zed.app"
      "/Applications/Utilities/Terminal.app"
    ];
    dock.persistent-others = [
      "/Applications"
      "/Users/thewellington"
      "/Users/thewellington/Documents"
      "/Users/thewellington/Downloads"
    ];
    dock.enable-spring-load-actions-on-all-items = true;
    dock.tilesize = 16;
    dock.largesize = 128;
    dock.show-recents = false;
  };
}
