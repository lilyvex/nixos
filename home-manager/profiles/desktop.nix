{pkgs, ...}: {
  imports = [
    ./main.nix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  lily = {
    hyprland.enable = true;
    ghostty.enable = true;
    neovim.enable = true;
    rofi.enable = true;
    vscode.enable = true;
    zed.enable = true;
    waybar.enable = true;
    chromium.enable = true;
  };
  home.packages = with pkgs; [
    vesktop
  ];
}
