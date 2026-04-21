{ pkgs, ...}:
{
  homebrew = {
    enable = true;
    user = "thewellington";
    brews = [
      #"mas"
    ];
    casks = [
      "1password"
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
      "quicksilver"
      "soundsource"
      "the-unarchiver"
      "qlstephen"
      "qlcommonmark"
      #"quicklook-json"
      #"1Password-cli"
      #"wkhtmltopdf"
      #"warp"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      # "Zeroconf Browser" = 1355001318;
      "Discovery - DNS-SD Browser" = 1381004916;
    };
    onActivation.cleanup = "uninstall"; # none, uninstsll, zap
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
