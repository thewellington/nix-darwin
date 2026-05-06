# home.nix

{ config, pkgs, lib, ... }:

{
  home.username = "thewellington";
  home.homeDirectory = "/Users/thewellington";
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";

  };

  # Let Home Manager install and manage itself.

  programs.git = {
    enable = true;
    userName = "thewellington";
    userEmail = "thewellington@gmail.com";
    lfs.enable = true;
    extraConfig = {
      core.excludesfile = "~/.gitignore";
      init.defaultBranch = "main";
      github.user = "thewellington";
      credential.helper = ["" "netlify" "osxkeychain"];
      include.path = "/Users/thewellington/.netlify/helper/git-config";
    };
  };

  programs.ghostty = {
      enable = true;
      # On macOS, ensure you use the binary package
      package = pkgs.ghostty-bin;

      settings = {
        # my quick terminal settings
        keybind = [ "global:ctrl+grave_accent=toggle_quick_terminal" ];
        "quick-terminal-position" = "top";
        "quick-terminal-size" = "30%,50%";

        "font-family" = "Source Code Pro";
        "font-family-bold" = "Source Code Pro Bold";
        "font-family-italic" = "Source Code Pro Italic";
        "font-family-bold-italic" = "Source Code Pro Bold Italic";
        "font-size" = "14";
        "window-padding-x" = "20";
        "window-padding-y" = "20";
        "window-padding-balance" = true;
        "window-height" = "20";
        "window-width" = "75";

        # Keep shell integration but disable auto-title so our zsh precmd title wins
        "shell-integration-features" = "no-title";

        # macOS specific features
        "macos-titlebar-style" = "tabs";
        "macos-option-as-alt" = true;
        "window-save-state" = "default";
        "window-vsync" = true;
        "window-colorspace" = "display-p3";
        "quick-terminal-screen" = "macos-menu-bar";
      };
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      add_newline = true;
      hostname.disabled = false;
      username.disabled = false;
      username.show_always = true;
      format = "$username$hostname$directory$git_branch$git_status$cmd_duration$jobs$character";
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = {
      ignorecase = true;
      number = true;
    };
    extraConfig = ''
      set mouse=a
    '';
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      # ENVIRONMENT VARIABLES
      export CLICOLOR=1
      # Example: directories bold cyan — edit the string to taste (see `man ls`, LSCOLORS)
      # export LSCOLORS=cxfxcxdxbxegedabagacad
      export LSCOLORS=exfxcxdxbxegedabagacad

      # STARSHIP
      eval "$(starship init zsh)"

      # NETLIFY
      if [ -f '/Users/thewellington/.netlify/helper/path.zsh.inc' ]; then source '/Users/thewellington/.netlify/helper/path.zsh.inc'; fi

      # GHOSTTY
      set_ghostty_title() {
        local tty_name=$(tty | sed 's|/dev/||')
        echo -ne "\e]0;''${tty_name}\a"
      }

      autoload -Uz add-zsh-hook
      add-zsh-hook precmd set_ghostty_title
    '';
  };

  home.file.".gitignore".text = ''
    # Mac
    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes

    # Windows
    ehthumbs.db
    Thumbs.db

    # General
    log/
    *.log

    # swap files
    ~*
    *.swp

    # BBedit
    *.bbprojectd

    # git
    w-*/ # hide worktrees

    # Netlify
    .netlify

    # Visual Studio Code
    .vscode/
    *.code-workspace

  '';
  # Create proper macOS aliases for Home Manager apps so they appear in
  # Dock, Launchpad, and Spotlight (symlinks from the Nix store don't work).
  home.activation.aliasApps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    app_folder="${config.home.homeDirectory}/Applications/Home Manager Aliases"
    rm -rf "$app_folder"
    mkdir -p "$app_folder"
    find "${config.home.homeDirectory}/Applications/Home Manager Apps" \
      -maxdepth 1 -type l -exec readlink '{}' + | \
    while read -r src; do
      app_name=$(basename "$src")
      echo "aliasing $app_name" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "$app_folder/$app_name"
    done
  '';

  home.sessionPath = [
    "${config.home.homeDirectory}/bin"
    "${config.home.homeDirectory}/.local/bin"

  ];

}
