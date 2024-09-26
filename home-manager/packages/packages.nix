{ pkgs, ... }:

{
  imports =
    [
      ./zsh.nix
      ./git.nix
      ./emacs.nix
      ./kitty.nix
    ];

  home.packages = with pkgs; [
     hyfetch
     nix-output-monitor
     firefox
     tree
     vesktop
     fzf
     tor-browser
     nix-search-cli
     mpv
     element-desktop
     mission-center
     nvtop
  ];

  nixpkgs.config.allowUnfree = true;
}
