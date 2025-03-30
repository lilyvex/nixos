{
  config,
  lib,
  ...
}: let
  cfg = config.lily.git;
in {
  options.lily.git = {
    enable = lib.mkEnableOption "activate git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      extraConfig = {
        user = {
          name = "Lily";
          email = "Caznix01@gmail.com";
          signingKey = "Caznix";
        };
        commit.gpgsign = true;
        init.defaultBranch = "main";
        merge = {
          ff = "no";
          no-commit = "yes";
        };
        pull.ff = "only";
        push = {autoSetupRemote = true;};
      };
    };
  };
}
