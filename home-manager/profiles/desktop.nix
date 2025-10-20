{pkgs, inputs, ...}: {
  imports = [
    ./main.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  lily = {
    emacs.enable = true;
    neovim.enable = true;
    vscode.enable = true;
  };
  home.packages = with pkgs; [
    blackbox-terminal
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

    mpv
    gparted

    keepassxc

    jetbrains.clion
    jetbrains.rust-rover
    jetbrains.webstorm

    gnome-extension-manager
    gnome-tweaks

    imagemagick
    brightnessctl

    weechat
  ];

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
