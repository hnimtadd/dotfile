{ config, pkgs, ... }:

  ###################################################################################
  #
  #  macOS's System configuration
  #
  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  #
  ###################################################################################
{
  system = {
    stateVersion = 5;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.applications.text = let
  env = pkgs.buildEnv {
    name = "system-applications";
    paths = config.environment.systemPackages;
    pathsToLink = "/Applications";
  };
in
  pkgs.lib.mkForce ''
  # Set up applications.
  echo "setting up /Applications..." >&2
  rm -rf /Applications/Nix\ Apps
  mkdir -p /Applications/Nix\ Apps

  find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  while read src; do
    app_name=$(basename "$src")
    echo "copying $src" >&2
    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
  done
      '';
    activationScripts.postUserActivation.text = ''
    # Install homebrew if it isn't there
    if [[ ! -d "/opt/homebrew/bin" ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

    defaults = {
        menuExtraClock.IsAnalog = true;
        finder.AppleShowAllExtensions = true;
        finder._FXShowPosixPathInTitle = true;
        finder.ShowPathbar = true;
        # NSGlobalDomain.KeyRepeat = 5;
        # NSGlobalDomain.InitialKeyRepeat = 2;

        loginwindow.LoginwindowText="Any fool can write code that a computer can understand. Good programmers write code that humans can understand.";
        dock.autohide = true;
        dock.orientation = "left";
        dock.static-only = true;
        dock.tilesize = 32;
    };
  };

    # Add ability to used TouchID for sudo authentication
    security.pam.enableSudoTouchIdAuth = true;

    # show extensions for file
    home-manager.backupFileExtension = "backup";
    }
