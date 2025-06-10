{ username, ... }:
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
  };
}
