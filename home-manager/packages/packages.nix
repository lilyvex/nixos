{ pkgs, ... }:

{
  imports =
    [
      ./zsh.nix
      ./git.nix
      ./emacs.nix
    ];

  home.packages = with pkgs; [
     rustup
     hyfetch
     nix-output-monitor
     alvr
     firefox
     tree
     vesktop
     kitty
     prismlauncher
  ];
}
