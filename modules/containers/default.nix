{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.lily.containers;
in {
  options.lily.containers = {
    enable = lib.mkEnableOption "activate containers";
    docker = lib.mkEnableOption "activate docker";
    podman = lib.mkEnableOption "activate podman";
  };

  config = lib.mkMerge [
    # (lib.mkIf (cfg.enable && cfg.docker && cfg.podman)
    #   (builtins.throw "You can't enable both docker and podman at the same time"))
    {
      assertions = [
        {
          assertion = !(cfg.docker && cfg.podman);
          message = "You cannot enable docker and podman at the same time";
        }
      ];
    }
    (lib.mkIf (cfg.enable && cfg.docker) {
      # Enable docker support:
      virtualisation.containers.enable = true;
      virtualisation.docker.enable = true;
    })
    (lib.mkIf (cfg.enable && cfg.podman) {
      # Enable podman support:
      virtualisation.containers.enable = true;
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
      environment.systemPackages = with pkgs; [
        podman
        podman-compose
      ];
    })
  ];
}
