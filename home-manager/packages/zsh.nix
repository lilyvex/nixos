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
      emacs-config = "emacs --chdir $HOME/.dotfiles/home-manager/packages/doom-emacs/.doom.d &";
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
      eval "$(fzf --zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_state$git_status$nix_shell$cmd_duration$line_break$python$character";

      directory = {
        style = "blue";
      };

      character = {
        success_symbol = "[❯](white)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style)";
        style = "green";
      };

      git_status = {
        format = "[[($conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "!";
        untracked = "​u";
        modified = "​*";
        staged = "​+";
        renamed = "r";
        deleted = "d";
        stashed = "≡";
      };

      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };
}
