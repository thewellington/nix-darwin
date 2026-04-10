{ pkgs, ...}:
{
  homebrew = {
    enable = true;
    user = "thewellington";
    casks = [
      "bettertouchtool"
      "the-unarchiver"
      "qlstephen"
      "qlcommonmark"
      #"quicklook-json"
      #"1Password-cli"
      #"wkhtmltopdf"
      #"warp"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
