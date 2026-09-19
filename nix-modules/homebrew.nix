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
      "bettertouchtool"
      "dropbox"
      # "font-source-code-pro"
      "gpg-suite"
      "hazel"
      # "hazeover" # gotta get through app store
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
      #"1Password-cli"
      #"wkhtmltopdf"
      #"warp"
      "whatcable"
    ];

    masApps = {
      # "1Password for Safari" = 1569813296;
      # "Discovery - DNS-SD Browser" = 1381004916;
    };

    onActivation.cleanup = "zap"; # none, uninstall, zap
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
