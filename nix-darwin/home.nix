{ config, pkgs, ... }:

let
  configDir = "${config.home.homeDirectory}/config";
  link = path: { source = config.lib.file.mkOutOfStoreSymlink "${configDir}/${path}"; };
in
{
  home.username = "ianliu";
  home.homeDirectory = "/Users/ianliu";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;
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
    ".aerospace.toml" = link "aerospace/.aerospace.toml";

    # TUI tools
    ".config/superfile/config.toml" = link "superfile/.config/superfile/config.toml";
    ".config/superfile/hotkeys.toml" = link "superfile/.config/superfile/hotkeys.toml";
    ".config/lazygit/config.yml" = link "lazygit/.config/lazygit/config.yml";
    ".config/lazydocker/config.yml" = link "lazydocker/.config/lazydocker/config.yml";
    ".config/k9s" = link "k9s/.config/k9s";

    # Nix
    ".config/nix" = link "nix/.config/nix";

    # AI tools
    ".config/mcphub/servers.json" = link "mcphub/.config/mcphub/servers.json";
    ".gemini/settings.json" = link "gemini/.gemini/settings.json";
    ".gemini/commands" = link "gemini/.gemini/commands";
    ".claude/settings.json" = link "claude/.claude/settings.json";
    ".claude/settings.local.json" = link "claude/.claude/settings.local.json";
    ".claude/remote-settings.json" = link "claude/.claude/remote-settings.json";
    ".claude/agents" = link "claude/.claude/agents";
    ".claude/output-styles" = link "claude/.claude/output-styles";
    ".claude/commands" = link "claude/.claude/commands";
    ".claude/.claude.json" = link "claude/.claude/.claude.json";
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

  programs.home-manager.enable = true;
}
