{ pkgs, ... }:

{
  imports =
    [
      ./zsh.nix
      ./git.nix
      ./emacs.nix
      ./kitty.nix
      ./hyprland/hyprland.nix
    ];

  home.packages = with pkgs; [
     rustup
     hyfetch
     nix-output-monitor
     alvr
     firefox
     tree
     vesktop
     prismlauncher
     fzf
     zoxide
     tor-browser
     nix-search-cli
     mpv
     dolphin
  ];
}
