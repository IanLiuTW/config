{
  description = "Ian Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-formulae = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, homebrew-formulae, rust-overlay }:
    let
      configuration = { pkgs, config, ... }: {
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgs; [
          swift
          darwin.apple_sdk.frameworks.Foundation
          darwin.apple_sdk.frameworks.CoreFoundation

          gettext
          mkalias
          cmake
          git
          curl
          jq
          fd
          wget
          ripgrep
          _7zz-rar
          sqlite

          asdf-vm
          lua5_1
          lua51Packages.luarocks
          nodejs_23
          python312

          neovim
          starship
          bat
          eza
          zoxide
          fzf

          lazygit
          lazydocker
          delta
          yazi
          imagemagick
          ffmpegthumbnailer
          poppler
          pngpaste
          lynx

          ice-bar
          aerospace
          jankyborders
          nerdfetch
          dwt1-shell-color-scripts
          ascii-image-converter

          raycast
          obsidian
          discord
        ];

        homebrew = {
          enable = true;
          brews = [
            "bpytop"
            "sops"
            "go-jira"
            "docker"
            "docker-compose"
            "docker-buildx"
            "docker-credential-helper"
            "colima"
            "sketchybar"
            "aichat"
            "posting"
            # "podman"
            # "podman-compose"
          ];
          casks = [
            "middleclick"
            "ghostty"
            "hammerspoon"
            "stats"
            "brave-browser"
            "google-chrome"
            "devpod"
            "postman"
            "mongodb-compass"
            "dbvisualizer"
            "gitbutler"
            "devtoys"
            "zed"
            "chatgpt"
            "claude"
            "element"
            "microsoft-teams"
            "zoom"
            "tidal"
            "spotify"
            "tunnelblick"
            "citrix-workspace"
            # "podman-desktop"
          ];
          masApps = {
            "Slack" = 803453959;
            "Outlook" = 985367838;
            "Word" = 462054704;
            "Excel" = 462058435;
            "PowerPoint" = 462062816;
            "Line" = 539883307;
          };
          onActivation.cleanup = "zap"; # remove unused packages, can be removed if erring.
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

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
        ];
        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        system.defaults = { };

        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        programs.zsh.enable = true;

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
      # $ darwin-rebuild build --flake .#MacBook-Pro---Tupl
      darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "ianliu";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                "FelixKratz/homebrew-formulae" = inputs.homebrew-formulae;
              };
              mutableTaps = false;
            };
          }
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [
              (pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
                # targets = [ "arm-unknown-linux-gnueabihf" ];
              })
            ];
          })
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."work".pkgs;

      homeConfigurations = {
        ianliu = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./home.nix
          ];
        };
      };
    };
}
