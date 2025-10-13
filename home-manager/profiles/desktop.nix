{pkgs, inputs, ...}: {
  imports = [
    ./main.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  lily = {
    niri.enable = true;
    niriswitcher.enable = true;
    rofi.enable = true;
    quickshell.enable = true;
    kitty.enable = true;
    neovim.enable = true;
    vscode.enable = true;
    tmux.enable = true;
  };
  home.packages = with pkgs; [
    vesktop
    inputs.zen-browser.packages."${system}".default
    hyfetch
    
    nerd-fonts.iosevka
    nerd-fonts.space-mono
    fira-sans

    prismlauncher
    mission-center

    appimage-run

    r2modman
    gamemode
    mangohud

    obs-studio
    mpv
    gparted

    keepassxc

    jetbrains.clion
    jetbrains.rust-rover
    jetbrains.webstorm
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
