{ pkgs, ...}: {
  networking = {
    computerName = "Doctor Teeth";
    hostName = "doctor-teeth";
    localHostName = "doctor-teeth";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    controlcenter.BatteryShowPercentage = true;
    dock.autohide = true;
    dock.magnification = true;
    dock.mineffect = "genie";
    dock.persistent-apps = [
      #Productivity
      "/Applications/Mimestream.app"
      "/Applications/Canary Mail.app"
      # "/Applications/Safari.app"
      "/System/Applications/Calendar.app"
      "/Applications/Things.app"

      # Communications
      "/System/Applications/Messages.app"
      "${pkgs.discord}/Applications/Discord.app"

      # Code
      "/Applications/BBEdit.app"
      "${pkgs.zed-editor}/Applications/Zed.app"
      "/Applications/Kaleidoscope.app"
      "/Applications/Tower.app"
      # "Applications/Transmit.app"

      # Creative tools ()

      # Office
      "/Applications/Microsoft\ Word.app"
      "/Applications/Microsoft\ Excel.app"
      "/Applications/Microsoft\ PowerPoint.app"
      "/Applications/pCalc.app"
      "${pkgs.iterm2}/Applications/iTerm2.app"
      "/System/Applications/Utilities/Console.app"
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
    finder.NewWindowTarget = "Home";
    finder.ShowExternalHardDrivesOnDesktop = false ;
    finder.ShowHardDrivesOnDesktop = false;
    finder.ShowMountedServersOnDesktop = false;
    finder.ShowPathbar = true;
    finder.ShowRemovableMediaOnDesktop = false;
    finder.ShowStatusBar = true;
    iCal."first day of week" = "System Setting";
    iCal."TimeZone support enabled" = true;
    iCal.CalendarSidebarShown = true;
    loginwindow.autoLoginUser = null;
    loginwindow.LoginwindowText = "Found this computer? Please contect W. S. Wellington at thewellington@gmail.com";
    loginwindow.SHOWFULLNAME = false;
    menuExtraClock.Show24Hour = true;
    menuExtraClock.ShowAMPM = false;
    menuExtraClock.ShowDate = 1;
    menuExtraClock.ShowDayOfWeek = false;
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 5;
    spaces.spans-displays = true;
    trackpad.Clicking = true;
    trackpad.Dragging = true;
    trackpad.DragLock = true;
    #universalaccess.closeViewScrollWheelToggle = true;
    WindowManager.EnableStandardClickToShowDesktop = false;
    WindowManager.StandardHideDesktopIcons = false;

  };
}
