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
    settings = {
        "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
        palette = {
              os = "#ACB0BE";
              pink = "#F5BDE6";
              lavender = "#B7BDF8";
              blue =  "#8AADF4";
              white = "#FFFFFF";
              text = "#494D64";
        };
        console_title_template = "{{.Folder}}{{if .Root}} :: root{{end}} :: {{.Shell}}";
        blocks = [
          {
            alignment = "left";
            newline = true;
            segments = [
              {
                background = "p:blue";
                foreground = "p:white";
                powerline_symbol = builtins.fromJSON '' "\ue0b4" '';
                leading_diamond = builtins.fromJSON '' "\ue0b6" '';
                style = "diamond";
                template = "{{.Icon}} ";
                type = "os";
              }
              {
                background = "p:blue";
                foreground = "p:text";
                powerline_symbol = builtins.fromJSON '' "\ue0b4" '';
                style = "diamond";
                template = "{{ .UserName }}@{{ .HostName }}";
                type = "session";
              }
              {
                background = "p:pink";
                foreground = "p:text";
                properties = {
                  folder_icon = "..\ue5fe..";
                  home_icon = "~";
                  style = "folder";
                };
                powerline_symbol = builtins.fromJSON '' "\ue0b4" '';
                style = "powerline";
                template = builtins.fromJSON '' " \udb81\udf70 {{ .Path }}" '';
                type = "path";
              }
              {
                background = "p:blue";
                foreground = "p:text";
                powerline_symbol = builtins.fromJSON '' "\ue0b4" '';
                template = builtins.fromJSON '' "{{if .Env.IN_NIX_SHELL}} \uf313 in nix-shell{{else}}{{end}}" '';
                style = "diamond";
                type = "text";
              }
              {
                background = "p:lavender";
                foreground = "p:text";
                style = "powerline";
                properties = {
                  branch_icon = builtins.fromJSON '' "\ue725 " '';
                  cherry_pick_icon = builtins.fromJSON '' "\ue29b " '';
                  commit_icon = builtins.fromJSON '' "\uf417 " '';
                  fetch_status = true;
                  fetch_upstream_icon = true;
                  fetch_bare_info = true;
                  merge_icon = builtins.fromJSON '' "\ue727 " '';
                  no_commits_icon = builtins.fromJSON '' "\uf0c3 " '';
                  rebase_icon = builtins.fromJSON '' "\ue728 " '';
                  revert_icon = builtins.fromJSON '' "\uf0e2 " '';
                  tag_icon = builtins.fromJSON '' "\uf412 " '';
                };
                powerline_symbol = builtins.fromJSON '' "\ue0b4" '';
                template = " {{ .HEAD }}{{ .Working }}";
                type = "git";
              }
              {
                background = "#f38ba8";
                foreground = "p:text";
                powerline_symbol = builtins.fromJSON '' "\ue0b4" '';
                template = builtins.fromJSON '' "{{if eq .Code 0}}{{else}} \uea87 {{.Code}}<#f38ba8,transparent>\ue0b4{{end}}" '';
                type = "status";
                style = "diamond";
              }
            ];
            type = "prompt";
          }
        ];
        final_space = true;
        version = 2;
      };
    };
}
