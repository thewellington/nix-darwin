{ pkgs, ...}:
{
  homebrew = {
    enable = true;
    user = "thewellington";
    brews = [
      #"mas"
      "brightness"
      "tag"
    ];

    casks = [
      "1password"
      "1password-cli"
      "arq"
      # "bettertouchtool" # recommended to get from website now, now homebrew
      "dropbox"
      # "font-source-code-pro"
      "gpg-suite"
      "hazel"
      # hazeover — managed via masApps
      "kaleidoscope"
      "little-snitch"
      "loopback"
      "microsoft-office"
      "nordvpn"
      "qgis"
      "quicksilver"
      "soundsource"
      "the-unarchiver"
      "qlstephen"
      "qlcommonmark"
      #"quicklook-json"
      #"wkhtmltopdf"
      #"warp"
      "whatcable"
    ];

    # App Store apps from `mas list`, excluding anything already in casks/brews or Nix.
    # (mas CLI itself is in systemPackages.)
    masApps = {
      "1Blocker" = 1365531024;
      "1Password for Safari" = 1569813296;
      "Aeon Timeline" = 1563351378;
      "Affinity Designer" = 824171161; # Affinity 1.x (MAS; v2+ is Serif/direct)
      "Affinity Photo" = 824183456;
      "Affinity Publisher" = 881418622;
      "Archiver 4" = 1556026599;
      "Boop" = 1518425043;
      "Brother P-touch Editor" = 1453365242;
      "Canary Mail" = 1236045954;
      "Cheatsheet" = 1468213484;
      "Cursor Pro" = 1447043133;
      "Dashlane" = 517914548;
      "Discovery" = 1381004916;
      "Flighty" = 1358823008;
      "GarageBand" = 682658836;
      "Gladys" = 1382386877;
      "GuruPro" = 891362701;
      "HazeOver" = 430798174;
      # "iMovie" = 408981434;
      "Infuse" = 1136220934;
      "Internet Access Policy Viewer" = 1482630322;
      # "Keynote" = 409183694; # /Applications/Keynote.app (14.5)
      "Keynote Creator Studio" = 361285480; # /Applications/Keynote Creator Studio.app (15.4)
      "Keystroke Pro" = 1572206224;
      "LG Screen Manager" = 1142051783;
      "Mactracker" = 430255202;
      "Mic Drop" = 1489816366;
      # "Numbers" = 409203825;
      "Numbers Creator Studio" = 361304891;
      # "Pages" = 409201541;
      "Pages Creator Studio" = 361309726;
      "Pastel" = 413897608;
      "PCalc" = 403504866;
      "ProLevel" = 526304550;
      "Things" = 904280696;
      "Time Timer" = 332520417;
      "WhatsApp" = 310633997;
      "WinZip" = 583827028;
      "World Clock Pro" = 858446756;
    };

    onActivation.cleanup = "uninstall"; # none, check, uninstall, zap
    # false avoids a nix-homebrew + brew auto-update re-exec bug that breaks masApps
    # ("Unable to install … mas installation failed" even when already installed).
    onActivation.autoUpdate = false;
    onActivation.upgrade = true;
  };
}
