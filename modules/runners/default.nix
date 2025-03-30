{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.lily.runners;
in {
  options.lily.runners.enable = lib.mkEnableOption "activate plasma";
  config = lib.mkIf cfg.enable {
    # Example 
    # age.secrets.lily.file = ./secrets/lily.age;
    # services.gitea-actions-runner = {
    #   package = pkgs.forgejo-runner;
    #   instances = {
    #     lilyvex = {
    #       enable = true;
    #       name = "caz-runner";
    #       #    token = runner-key;
    #       tokenFile = config.age.secrets.lily.path;
    #       url = "https://git.lilyvex.dev/";
    #       labels = [
    #         "node-22:docker://node:22-bookworm"
    #         "nixos-latest:docker://nixos/nix"
    #         "ubuntu-latest:docker://node:16-bullseye"
    #       ];
    #       #settings = { ... };
    #     };
    #   };
    # };
  };
}
