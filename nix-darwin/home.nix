{ config, pkgs, ... }:

let
  configDir = "${config.home.homeDirectory}/config";
  link = path: { source = config.lib.file.mkOutOfStoreSymlink "${configDir}/${path}"; };
in
{
  home.username = "ianliu";
  home.homeDirectory = "/Users/ianliu";
  home.stateVersion = "24.05";

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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

    # Git & Docker
    ".gitconfig" = link "git/.gitconfig";
    ".docker/config.json" = link "docker/.docker/config.json";

    # Window management
    ".hammerspoon" = link "hammerspoon/.hammerspoon";
    ".aerospace.toml" = link "aerospace/.aerospace.toml";
    ".config/sketchybar" = link "sketchybar/.config/sketchybar";

    # TUI tools
    ".config/yazi" = link "yazi/.config/yazi";
    ".config/lazygit/config.yml" = link "lazygit/.config/lazygit/config.yml";
    ".config/lazydocker/config.yml" = link "lazydocker/.config/lazydocker/config.yml";

    # Nix
    ".config/nix" = link "nix/.config/nix";

    # AI tools
    ".config/mcphub/servers.json" = link "mcphub/.config/mcphub/servers.json";
    ".gemini/settings.json" = link "gemini/.gemini/settings.json";
    ".gemini/commands" = link "gemini/.gemini/commands";
    ".claude/settings.json" = link "claude/.claude/settings.json";
    ".claude/agents" = link "claude/.claude/agents";
    ".claude/commands" = link "claude/.claude/commands";
    ".claude/.claude.json" = link "claude/.claude/.claude.json";
    ".claude/CLAUDE.md" = link "claude/.claude/CLAUDE.md";
    ".claude/statusline.sh" = link "claude/.claude/statusline.sh";
    ".claude/keybindings.json" = link "claude/.claude/keybindings.json";

    # Inline configs
    ".config/pycodestyle".text = ''
      [pycodestyle]
      max-line-length = 160
      ignore = E203, W503
    '';
  };

  programs.home-manager.enable = true;
}