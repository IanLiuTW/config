{ config, pkgs, ... }:

let
  configDir = "${config.home.homeDirectory}/config";
  link = path: { source = config.lib.file.mkOutOfStoreSymlink "${configDir}/${path}"; };
in
{
  home.stateVersion = "24.05";

  # The Sunday system GC runs as root and never expires these generations
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    timestamp = "-7 days";
  };

  home.packages = with pkgs; [
    # Rust
    bacon cargo-nextest cargo-release cargo-wizard git-cliff lld

    # Misc
    aoc-cli
  ];

  home.file = {
    # Shell & prompt
    ".zshrc" = link "zsh/.zshrc";
    ".config/starship.toml" = link "starship/.config/starship.toml";

    # Terminal & editor
    ".config/ghostty" = link "ghostty/.config/ghostty";
    ".config/nvim" = link "nvim/.config/nvim";
    ".config/zed/settings.json" = link "zed/.config/zed/settings.json";

    # Git
    ".gitconfig" = link "git/.gitconfig";

    # Window management
    ".hammerspoon" = link "hammerspoon/.hammerspoon";
    # OmniWM writes Settings-window changes through this symlink into the repo.
    ".config/omniwm/settings.toml" = link "omniwm/.config/omniwm/settings.toml";

    # TUI tools
    ".config/superfile/config.toml" = link "superfile/.config/superfile/config.toml";
    ".config/superfile/hotkeys.toml" = link "superfile/.config/superfile/hotkeys.toml";
    ".config/lazygit/config.yml" = link "lazygit/.config/lazygit/config.yml";
    ".config/k9s" = link "k9s/.config/k9s";

    # AI tools
    ".claude/settings.json" = link "claude/.claude/settings.json";
    ".claude/agents" = link "claude/.claude/agents";
    ".claude/output-styles" = link "claude/.claude/output-styles";
    ".claude/commands" = link "claude/.claude/commands";
    ".claude/CLAUDE.md" = link "claude/.claude/CLAUDE.md";
    ".claude/statusline.sh" = link "claude/.claude/statusline.sh";
    ".claude/keybindings.json" = link "claude/.claude/keybindings.json";
    # Linked per-file so ~/.claude/themes stays writable for the in-app editor.
    ".claude/themes/tokyonight-night.json" =
      link "claude/.claude/themes/tokyonight-night.json";
    ".config/herdr/config.toml" = link "herdr/.config/herdr/config.toml";

    # Inline configs
    ".config/pycodestyle".text = ''
      [pycodestyle]
      max-line-length = 160
      ignore = E203, W503
    '';
  };

  # Per-app macOS menu shortcut overrides. Ghostty: move the native-tab
  # shortcuts off ctrl+tab so it reaches the terminal (herdr workspace nav).
  targets.darwin.defaults."com.mitchellh.ghostty".NSUserKeyEquivalents = {
    "Hide Ghostty" = "@$h";
    "Show Next Tab" = "@~^$n";
    "Show Previous Tab" = "@~^$p";
  };
}
