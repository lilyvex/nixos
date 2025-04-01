{pkgs, inputs, ...}: {
  imports = [
    ./main.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  lily = {
    hyprland.enable = true;
    kitty.enable = true;
    neovim.enable = true;
    rofi.enable = true;
    waybar.enable = true;
  };
  home.packages = with pkgs; [
    vesktop
    inputs.zen-browser.packages."${system}".default
    hyfetch
    
    nerd-fonts.iosevka
    nerd-fonts.space-mono
    fira-sans

    prismlauncher
  ];
}
