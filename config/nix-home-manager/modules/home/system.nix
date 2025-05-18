{ pkgs, username, lib, config, ... }:
#########################
#
# Home manager system config
#
#########################
{
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    username = "${username}";
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";

    # This will run the `home-manager switch` command
    activation = {
      rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
        apps_source="$genProfilePath/home-path/Applications"
        moniker="Home Manager Trampolines"
        app_target_base="${config.home.homeDirectory}/Applications"
        app_target="$app_target_base/$moniker"
        mkdir -p "$app_target"
              ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
      '';
    };
  };
}
