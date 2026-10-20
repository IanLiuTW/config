{
  description = "Ian Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # nix-homebrew pins brew-src to a fixed tag, but the taps below are bumped
    # daily. Casks/formulae start using new Homebrew DSL methods as soon as they
    # ship, so a lagging brew makes `brew bundle` abort the whole activation
    # ("undefined method ... for Homebrew::InstallSteps::DSL"). Track brew's
    # default branch so the daily flake update moves brew with its taps.
    brew-src = {
      url = "github:Homebrew/brew";
      flake = false;
    };
    nix-homebrew.inputs.brew-src.follows = "brew-src";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    herdr = {
      url = "github:ogulcancelik/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
      # herdr pins an older rust-overlay that still uses stdenv.isLinux/isDarwin;
      # reuse ours so eval stays warning-free and only one toolchain is built.
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, rust-overlay, herdr, ... }:
    let
      configuration = { pkgs, config, ... }: {
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgs; [
          # System tools - CLI
          ffmpeg
          gettext
          cmake
          git
          git-lfs
          curl
          jq
          fd
          wget
          ripgrep
          dua
          procs
          _7zz-rar
          just
          # System tools - GUI
          fastfetch
          dwt1-shell-color-scripts
          ascii-image-converter
          # Programming languages and tools
          lua5_1
          lua51Packages.luarocks
          nodejs_24
          pnpm
          (python314.withPackages (ps: [ ps.pip ]))
          uv
          # CLI tools
          neovim
          tree-sitter
          starship
          bat
          eza
          zoxide
          fzf
          # Development dependencies
          nixfmt # Mason's nixfmt package is Linux-only
          delta
          imagemagick
          ffmpegthumbnailer
          exiftool
          poppler
          pngpaste
          lynx
          sqlite
          # Development tools
          jujutsu
          colima
          lazygit
          lazydocker
          posting
          gh
          kubectl
          kubernetes-helm
          fluxcd
          k9s
          # AI tools
          antigravity-cli
          herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
          # Applications
          # discord
        ];

        homebrew = {
          enable = true;
          brews = [
            # System tools
            "btop"
            "superfile"
            # "sketchybar" - replaced by ice-bar
            # Development tools
            "docker"
            "docker-compose"
            "docker-buildx"
            "docker-credential-helper"
            # "podman"
            # "podman-compose"
            "sops"
            # Project tools
            "go-jira"
            # Others
            "yt-dlp"
          ];
          casks = [
            # System tools
            # If the three-finger tap silently stops working, the Accessibility
            # grant has gone stale (upstream issue #162) - toggle MiddleClick off
            # and on in Privacy & Security > Accessibility. Input Monitoring is
            # not required. "middle" is the paid alternative.
            "middleclick"
            "linearmouse"
            "hammerspoon"
            "stats"
            # Fully-qualified so nix-darwin emits `trusted: true` (see below).
            "dannystewart/apps/volumehud"
            "thaw"
            "raycast"
            # Window manager (replaced AeroSpace + JankyBorders). The cask tracks
            # upstream releases; nixpkgs' omniwm trails them.
            "omniwm"
            # Web browsers
            "brave-browser"
            "google-chrome"
            "microsoft-edge@beta"
            # Development tools
            "ghostty"
            "devpod"
            # "podman-desktop"
            "postman"
            "dbeaver-community"
            "mongodb-compass"
            "devtoys"
            "zed"
            # AI tools
            "chatgpt"
            "claude"
            "codex"
            "claude-code@latest"
            # Communication
            "microsoft-teams"
            # Media
            "spotify"
            "obs"
            "vlc"
            # Remote access and VPN
            "tunnelblick"
          ];
          # Declare every tap in the Brewfile so `brew bundle --zap` doesn't
          # untap them on activation: the nix-homebrew-managed ones, plus
          # dannystewart/apps (tapped at runtime for the volumehud cask).
          taps = builtins.attrNames config.nix-homebrew.taps ++ [ "dannystewart/apps" ];
          onActivation.cleanup = "uninstall"; # remove undeclared packages (keeps their data; use "zap" to also wipe data).
          # Taps are nix flake inputs (refreshed by the daily nix-flake-update
          # agent), so `brew update` must never run: it re-clones the git repo
          # that nix-homebrew's rsync deletes on every activation (a 1+ GiB
          # download each rebuild) and litters the tap with symlinks that make
          # the rsync warn hundreds of times.
          onActivation.autoUpdate = false;
          onActivation.upgrade = true;
        };

        # `brew bundle` runs during activation and loads
        # $HOMEBREW_PREFIX/etc/homebrew/brew.env first. volumehud lives in the
        # third-party dannystewart/apps tap; Homebrew 6.0+ refuses to load casks
        # from untrusted taps, and the bundle cleanup pass loads every cask to
        # compute prunes, so it fails on volumehud and aborts the switch.
        #
        # The cask is declared by its fully-qualified name (see homebrew.casks)
        # so nix-darwin emits `trusted: true` on its Brewfile line.
        # homebrew.casks.*.trusted already defaults to true, but it only takes
        # effect for user/repo/cask names: a bare name maps to no tap, so
        # `brew bundle` skips it. `brew bundle` writes the trust entry before it
        # loads any entry, so the cleanup pass that follows can read the cask.
        # Drop the qualified name when volumehud goes.
        #
        # HOMEBREW_XDG_CONFIG_HOME keeps activation and interactive runs on one
        # trust store. The store is $XDG_CONFIG_HOME/homebrew/trust.json, else
        # ~/.homebrew/trust.json, and activation runs brew through
        # `sudo --preserve-env=PATH`, which drops XDG_CONFIG_HOME. Without this
        # the two runs write and read different files, and an interactive
        # `brew cleanup` keeps failing on the cask that activation trusted.
        #
        # This replaces HOMEBREW_NO_REQUIRE_TAP_TRUST, which is deprecated
        # upstream.
        #
        # NO_AUTO_UPDATE also applies to interactive brew runs: an auto-update
        # would re-clone the nix-managed taps (see onActivation.autoUpdate).
        system.activationScripts.homebrew.text = pkgs.lib.mkBefore ''
          install -d /opt/homebrew/etc/homebrew
          printf '%s\n' 'HOMEBREW_XDG_CONFIG_HOME=/Users/ianliu/.config' 'HOMEBREW_NO_AUTO_UPDATE=1' \
            > /opt/homebrew/etc/homebrew/brew.env
        '';

        fonts.packages = with pkgs; [
          nerd-fonts.caskaydia-mono
          nerd-fonts.caskaydia-cove
          nerd-fonts.hack
          nerd-fonts.commit-mono
          nerd-fonts._0xproto
          nerd-fonts.monofur
          nerd-fonts.code-new-roman
          nerd-fonts.sauce-code-pro
          nerd-fonts.dejavu-sans-mono
          nerd-fonts.terminess-ttf
          nerd-fonts.bigblue-terminal
          victor-mono
          inter
        ];
        # Claude Code settings that must stay out of this public repo live in a
        # gitignored file. Claude Code combines autoMode.environment from managed
        # settings with ~/.claude/settings.json, so it sees both.
        system.activationScripts.postActivation.text = ''
          src=/Users/ianliu/config/claude/managed-settings.local.json
          dst="/Library/Application Support/ClaudeCode/managed-settings.d/50-local.json"
          if [ -f "$src" ]; then
            install -d -m 755 "''${dst%/*}"
            install -m 644 "$src" "$dst"
          else
            rm -f "$dst"
          fi
        '';

        environment.etc."sudoers.d/timestamp_timeout".text = ''
          Defaults timestamp_timeout=60
        '';

        # ~/.claude/skills is a separate private clone; the agent does nothing on
        # a Mac without it.
        launchd.user.agents.claude-skills-pull = {
          serviceConfig = {
            ProgramArguments = [
              "/bin/sh" "-c"
              ''
                [ -d "$HOME/.claude/skills/.git" ] || exit 0
                [ "$(git -C "$HOME/.claude/skills" branch --show-current)" = master ] || exit 0
                ping -c 1 -W 1000 8.8.8.8 >/dev/null 2>&1 || exit 0
                i=0
                while :; do
                  if { cd "$HOME/.claude/skills" && git pull; } \
                       >"$HOME/Library/Logs/claude-skills-pull.log" 2>&1; then
                    exit 0
                  fi
                  i=$((i + 1))
                  [ "$i" -ge 3 ] && break
                  sleep 60
                done
                /usr/bin/osascript -e 'display notification "claude-skills-pull failed after 3 retries (see ~/Library/Logs/claude-skills-pull.log)" with title "Cron job failed"'
              ''
            ];
            StartCalendarInterval = [{ Hour = 8; Minute = 0; }];
            StandardOutPath = "/dev/null";
            StandardErrorPath = "/dev/null";
            RunAtLoad = false;
          };
        };

        launchd.user.agents.nix-flake-update = {
          serviceConfig = {
            ProgramArguments = [
              "/bin/sh" "-c"
              ''
                i=0
                while :; do
                  if ping -c 1 -W 1000 8.8.8.8 >/dev/null 2>&1 \
                    && /run/current-system/sw/bin/nix flake update --flake "$HOME/config/nix-darwin/" \
                         >"$HOME/Library/Logs/nix-flake-update.log" 2>&1; then
                    exit 0
                  fi
                  i=$((i + 1))
                  [ "$i" -ge 3 ] && break
                  sleep 14400
                done
                /usr/bin/osascript -e 'display notification "nix-flake-update failed after 3 retries (see ~/Library/Logs/nix-flake-update.log)" with title "Cron job failed"'
              ''
            ];
            StartCalendarInterval = [{ Hour = 8; Minute = 0; }];
            StandardOutPath = "/dev/null";
            StandardErrorPath = "/dev/null";
            RunAtLoad = false;
          };
        };

        system.primaryUser = "ianliu";

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Automatic store cleanup: weekly GC of system generations older than 7
        # days, plus hardlink-dedupe of identical store files. It runs as root, so
        # Home Manager and user-profile generations need `nix-clean`.
        nix.gc = {
          automatic = true;
          interval = { Weekday = 0; Hour = 3; Minute = 0; };  # weekly, Sun 3am
          options = "--delete-older-than 7d";
        };
        nix.optimise.automatic = true;

        # Enable alternative shell support in nix-darwin.
        programs.zsh.enable = true;
        # .zshrc runs its own cached compinit (zicompinit_fast) and starship sets
        # the prompt, so skip /etc/zshrc's second compinit, bashcompinit (nothing
        # uses bash `complete`) and promptinit. Saves ~60 ms per interactive shell.
        programs.zsh.enableGlobalCompInit = false;
        programs.zsh.enableBashCompletion = false;
        programs.zsh.promptInit = "";

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#work
      darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          # home.nix is applied by `darwin-rebuild switch`; there is no separate
          # home-manager switch. It shares this system's pkgs (overlays, unfree).
          home-manager.darwinModules.home-manager
          {
            users.users.ianliu.home = "/Users/ianliu";
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # Rename a pre-existing file in the way instead of aborting activation.
              backupFileExtension = "before-hm";
              users.ianliu = import ./home.nix;
            };
          }
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = false;
              user = "ianliu";
              taps = {
                "homebrew/homebrew-core" = inputs.homebrew-core;
                "homebrew/homebrew-cask" = inputs.homebrew-cask;
              };
              mutableTaps = true;
            };
          }
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
            ];
            environment.systemPackages = [
              (pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
              })
            ];
          })
        ];
      };
    };
}
