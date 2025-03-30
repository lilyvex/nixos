{
  config,
  lib,
  ...
}: let
  cfg = config.lily.fileshare;
in {
  options.lily.fileshare.enable = lib.mkEnableOption "activate local filesharing";

  config = lib.mkIf cfg.enable {
    services.samba = {
      enable = true;
      securityType = "user"; #Keep user, but use guest account.
      openFirewall = true;
      settings = {
        global = {
          workgroup = "WORKGROUP"; #Ensure this matches your network's workgroup.
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user"; #Keep this as user, but guest will be used for access.
          "hosts allow" = "192.168.1. 127.0.0.1 localhost"; #Adjust to your LAN.
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody"; #Important for guest access.
          "map to guest" = "bad user"; #Maps unknown users to guest.
        };
        "public" = {
          "path" = "/ext/share";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes"; #Allows guest access.
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
    services.avahi = {
      enable = true;
      nssmdns = true;
      nssmdns4 = true;
      openFirewall = true;
      reflector = true;
      publish = {
        domain = true;
        enable = true;
        userServices = true;
        addresses = true;
      };
    };
  };
}
