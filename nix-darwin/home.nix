{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ianliu";
  home.homeDirectory = "/Users/ianliu";

  # programs.zsh.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    cargo-nextest
    aoc-cli

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
    ".config/nix" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/nix/.config/nix"; };
    ".zshrc" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/zsh/.zshrc"; };
    ".config/starship.toml" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/starship/.config/starship.toml"; };

    ".config/ghostty" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/ghostty/.config/ghostty"; };
    ".config/nvim" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/nvim/.config/nvim"; };

    ".gitconfig" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/git/.gitconfig"; };
    ".docker/config.json" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/docker/.docker/config.json"; };

    ".hammerspoon" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/hammerspoon/.hammerspoon"; };
    ".aerospace.toml" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/aerospace/.aerospace.toml"; };
    ".config/sketchybar" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/sketchybar/.config/sketchybar"; };

    ".config/yazi" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/yazi/.config/yazi"; };
    ".config/lazygit/config.yml" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/lazygit/.config/lazygit/config.yml"; };
    ".config/lazydocker/config.yml" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/lazydocker/.config/lazydocker/config.yml"; };

    ".config/mcphub/servers.json" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/mcphub/.config/mcphub/servers.json"; };
    ".gemini/settings.json" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/ianliu/config/gemini/.gemini/settings.json"; };

    ".config/pycodestyle".text = ''
      [pycodestyle]
      max-line-length = 160
      ignore = E203, W503
    '';

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ianliu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "nvim";
    # POETRY_VIRTUALENVS_IN_PROJECT = "true";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
