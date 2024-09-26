{ ... }:

{
  programs.git = {
    enable = true;
    userName = "luxzi";
    userEmail = "lesson085@gmail.com";
    aliases = {
      pf = "push --force";
      kl = "log --show-signature";
    };
    signing = {
      key = "C90237A70F2FDD53";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.symlinks = true;
      commit.gpgsign = true;
    };
  };
}
