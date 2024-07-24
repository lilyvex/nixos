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
      key = "$HOME/.ssh/luxzi";
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
