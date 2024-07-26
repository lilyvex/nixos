{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
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

    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
      ];
    };

    history = {
      size = 5000;
      save = 5000;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    initExtra = ''
      bindkey -v
      bindkey '^k' history-search-backward
      bindkey '^j' history-search-forward
      setopt appendHistory
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "catppuccin_mocha";
  };
}
