{ pkgs, ... }:

{
  imports = 
    [
      ./nix-ld.nix
      ./dconf.nix
      ./gpg.nix
      ./steam.nix
    ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    neovim
    fira-code-nerdfont
    cmake
    ninja
    libgcc
    gnumake
    topgrade
    unzip
    patchelf
    wl-clipboard
    jdk17
    jre8
    python3
  ];
}
