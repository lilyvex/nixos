{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.lily.users.lily;
  #   interpolated_secrets = import ../../secrets/interpolated_secrets.nix;
in {
  options.lily.users.lily.enable = lib.mkEnableOption "activate user lily";
  config = lib.mkIf cfg.enable {
    users.users.lily = {
      home = "/home/lily";
      isNormalUser = true;
      #   hashedPasswordFile = lib.mkIf config.lily.sops config.sops.secrets."users/lily/hashedPassword".path;
      extraGroups = ["wheel" "docker"] ++ lib.optionals config.networking.networkmanager.enable ["networkmanager"];
      shell = pkgs.zsh;
    };
    # sops.secrets."users/lily/hashedPassword" = lib.mkIf config.lily.sops { neededForUsers = true; };
  };
}
