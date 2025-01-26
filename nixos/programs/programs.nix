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
    nerd-fonts.fira-code
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
    clang-tools
    clang
    libtool
    libvterm
    pkg-config
    openssl
  ];
}
