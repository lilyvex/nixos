{pkgs, inputs, ...}: {
  imports = [
    ./main.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  lily = {
    hyprland.enable = false;
    kitty.enable = true;
    neovim.enable = true;
    rofi.enable = false;
    waybar.enable = false;
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
    element-desktop
    mission-center

    appimage-run

    r2modman
    gamemode
    mangohud
    albert

    obs-studio
    mpv
    gparted
    bottles

    keepassxc
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    kdePackages.xdg-desktop-portal-kde
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Breeze";
    XCURSOR_SIZE = "24";
  };
}
