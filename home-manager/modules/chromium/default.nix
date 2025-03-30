{
  config,
  lib,
  ...
}: let
  cfg = config.lily.chromium;
in {
  options.lily.chromium = {
    enable = lib.mkEnableOption "activate chromium";
  };
  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
        {id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";} # privacy badger
        {id = "ldpochfccmkkmhdbclfhpagapcfdljkj";} # decentraleyes
        {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsor block
        {id = "gebbhagfogifgggkldgodflihgfeippi";} # return youtube dislike (just cuz)
      ];
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    };
  };
}
