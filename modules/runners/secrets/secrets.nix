let
  lily = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHj4f4GlA+DP491i9ssmm+Ys/TLikz6ALk1kkglhcywY lily@GreenMachine";
  users = [lily];
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/rgN3hR4K2Mu/Oy3tgaGfDfCss3CrNJn2jTTQJQKKn root@nixos";
  systems = [system];
in {
  #    age.secrets.potato.file = ./potato.age;
  #    age.secrets.lily.file = ./lily.age;
  "potato.age".publicKeys = [
    lily

    system
  ];
  "lily.age".publicKeys = [
    lily

    system
  ];
}
