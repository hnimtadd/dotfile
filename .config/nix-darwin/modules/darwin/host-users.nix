
{ hostname, username, ... }:

#############################################################
#
#  Host & Users configuration
#
#############################################################

{
  networking.hostName = hostname;
  networking.computerName = hostname;

  users.users."${username}"= {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [ username ];
}
