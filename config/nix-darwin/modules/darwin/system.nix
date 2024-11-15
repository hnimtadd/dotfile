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
    activationScripts.postUserActivation.text = ''
        # Install homebrew if it isn't there
        if [[ ! -d "/opt/homebrew/bin" ]]; then
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      apps_source="${config.system.build.applications}/Applications"
      moniker="Nix Trampolines"
      app_target_base="$HOME/Applications"
      app_target="$app_target_base/$moniker"
      mkdir -p "$app_target"
      ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
    '';

    defaults = {
      # disable digital clock since Stats will handle this, disable this if you want the default clock from MacOS
      menuExtraClock.IsAnalog = true;

      # config finder app
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = false;
      finder.ShowPathbar = true;
      finder.ShowStatusBar = true;

      loginwindow.LoginwindowText = "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.";
      loginwindow.SHOWFULLNAME = false;

      # dock related settings
      dock.autohide = true;
      dock.orientation = "left";
      dock.static-only = true;
      dock.tilesize = 32;
      dock.mineffect = "suck";
      dock.minimize-to-application = true;
      # disable show the desktop if focus on the wallpaper
      WindowManager.EnableStandardClickToShowDesktop = false;

      # keymap
      # setting repeat key on hold
      NSGlobalDomain.KeyRepeat = 2;
      NSGlobalDomain.InitialKeyRepeat = 25;
      NSGlobalDomain.ApplePressAndHoldEnabled = false;

      # enable trackpad tap to click
      trackpad.Clicking = true;

      # disable animation when switching screens or opening apps
      universalaccess.reduceMotion = true;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
