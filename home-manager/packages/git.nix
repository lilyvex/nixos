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
      key = "/home/luxzi/.ssh/luxzi";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "/home/luxzi/.ssh/allowed_signers";
      core.symlinks = true;
    };
  };
}
