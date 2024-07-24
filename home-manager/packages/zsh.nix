{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "af-magic";
    };
    shellAliases = {
      hm-switch = "home-manager switch --flake $HOME/.dotfiles"; 
      nx-switch = "sudo nixos-rebuild switch --flake $HOME/.dotfiles";
      nx-boot = "sudo nixos-rebuild boot --flake $HOME/.dotfiles";
      nx-clean = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
      hm-clean = "home-manager remove-generations";
      gl-switch = "sudo nixos-rebuild switch --flake $HOME/.dotfiles && home-manager switch --flake $HOME/.dotfiles";
      gl-clean = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old && home-manager remove-generations";
      snv = "sudo -E nvim";
      sen = "sudo -E";
    };
  };
}
