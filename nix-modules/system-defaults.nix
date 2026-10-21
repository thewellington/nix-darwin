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
      "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
      "/System/Applications/Calendar.app"
      "/Applications/Things3.app"

      # Communications
      "/System/Applications/Messages.app"
      "/Users/thewellington/Applications/Home Manager Apps/Discord.App"
      "/Applications/Signal.app"
      "/Applications/WhatsApp.app"
      "/System/Applications/Phone.app"

      # Code
      { spacer = { small = true; }; }
      "/Applications/BBEdit.app"
      "${pkgs.zed-editor}/Applications/Zed.app"
      "/Applications/Cursor.app"
      "/Applications/Kaleidoscope.app"
      "/Applications/Tower.app"
      "/Applications/Transmit.app"
      "/Applications/TablePlus.app"
      # "/Applications/Table\ Tool.app"

      # Creative tools (Adobe)
      { spacer = { small = true; }; }
      "/Applications/Adobe\ Photoshop\ 2026/Adobe\ Photoshop\ 2026.app"
      "/Applications/Adobe\ Lightroom\ Classic/Adobe\ Lightroom\ Classic.app"
      "/Applications/Adobe\ Illustrator\ 2026/Adobe\ Illustrator.app"
      "/Applications/Adobe\ Acrobat\ DC/Adobe\ Acrobat.app"

      "/Applications/Pastel.app"

      # Creative (Affinity apps)
      "/Applications/Affinity\ Designer.app"
      "/Applications/Affinity\ Publisher.app"
      "/Applications/Affinity\ Photo.app"


      # Creative (Nik Collection)
      "/Applications/Nik\ Collection\ 8/Nik\ 8\ Silver\ Efex.app"
      "/Applications/Nik\ Collection\ 8/Nik\ 8\ Presharpener.app"
      "/Applications/Nik\ Collection\ 8/Nik\ 8\ Sharpener\ Output.app"

      # Creative (Audio tools)
      "/Applications/Fission.app"

      # Office
      { spacer = { small = true; }; }
      "/Applications/Microsoft\ Word.app"
      "/Applications/Microsoft\ Excel.app"
      "/Applications/Microsoft\ PowerPoint.app"
      "/Applications/Pages\ Creator\ Studio.app"
      "/Applications/Numbers\ Creator\ Studio.app"
      "/Applications/Keynote\ Creator\ Studio.app"

      # AI
      "/Applications/Cursor.app"

      # Utilities
      { spacer = { small = true; }; }
      "/Applications/pCalc.app"
      #"${pkgs.iterm2}/Applications/iTerm2.app"
      "/Users/thewellington/Applications/Home Manager Apps/Ghostty.app"
      "/System/Applications/Utilities/Terminal.app"
      "/System/Applications/Utilities/Activity\ Monitor.app"
      "/System/Applications/Utilities/Console.app"

    ];
    dock.persistent-others = [
      # arrangement: name | date-added | date-modified | date-created | kind
      # displayas:   stack | folder
      # showas:      automatic | fan | grid | list
      { folder = {
        path = "/Applications";
        arrangement = "name";
        displayas = "stack";
        showas = "grid";
      }; }
      { folder = {
        path = "/Users/thewellington";
        arrangement = "name";
        displayas = "folder";
        showas = "grid";
      }; }
      { folder = {
        path = "/Users/thewellington/Documents";
        arrangement = "name";
        displayas = "folder";
        showas = "grid";
      }; }
      { folder = {
        path = "/Users/thewellington/Library/CloudStorage/Dropbox";
        arrangement = "name";
        displayas = "folder";
        showas = "grid";
      }; }
      { folder = {
        path = "/Users/thewellington/Downloads";
        arrangement = "date-added";
        displayas = "stack";
        showas = "fan";
      }; }
    ];
    dock.enable-spring-load-actions-on-all-items = true;
    dock.tilesize = 16;
    dock.largesize = 128;
    dock.show-recents = false;
    dock.expose-group-apps = true;
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
    loginwindow.LoginwindowText = "Found this computer? Please contact W. S. Wellington at thewellington@gmail.com";
    loginwindow.SHOWFULLNAME = true;
    menuExtraClock.Show24Hour = true;
    menuExtraClock.ShowAMPM = false;
    menuExtraClock.ShowDate = 1;
    menuExtraClock.ShowDayOfWeek = false;
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 5;
    spaces.spans-displays = false;
    trackpad.Clicking = true;
    trackpad.Dragging = true;
    trackpad.DragLock = true;
    #universalaccess.closeViewScrollWheelToggle = true;
    WindowManager.EnableStandardClickToShowDesktop = false;
    WindowManager.StandardHideDesktopIcons = false;

    NSGlobalDomain = {
      NSWindowShouldDragOnGesture = true; # allows cmd-ctrl to drag on any window
      # Lower = faster. macOS defaults are roughly KeyRepeat=6, InitialKeyRepeat=25.
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      # false = key repeat on hold; true = accent popup (blocks repeat)
      ApplePressAndHoldEnabled = false;
      AppleInterfaceStyle = "Dark";
    };

    CustomUserPreferences = {
      "NSGlobalDomain" = { # use for defaults that are not available via Nix
        # NSSplitViewItemSidebarDefaultsToFloatingAppearance = false; # Default true - turns off floating sidebar in Finder windows
        # NSConvolutionOverride1 = 10; # Default 26 - set Finder window corner radius
        # NSSplitViewItemGlassMinimumCornerRadius = 10; # default 19 - Set sidebar corner radius in Finder windows
        # NSQuitAlwaysKeepsWindows = false;
        "com.apple.trackpad.scaling" = 2.0;
        "com.apple.mouse.scaling" = 2.0;
      };
    };
  };
}
