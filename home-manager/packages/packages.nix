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
  ];
}
