{
  config,
  lib,
  ...
}: let
  cfg = config.lily.zsh;
in {
  options.lily.zsh = {
    enable = lib.mkEnableOption "activate zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };
      initContent = ''
        if [ -z "$TMUX" ] && command -v tmux >/dev/null; then
          exec tmux
        fi
      '';
      autosuggestion.enable = true;
      autosuggestion.strategy = [
        "completion"
        "history"
      ];
      shellAliases = {
        nix-switch = "sudo nixos-rebuild switch --flake $HOME/.dotfiles";
        ls = "eza";
        cd = "z";
        hyfetch = "hyfetch --args='--disable resolution bios network icons cursor --colors 7 4 4 2 2 7'";
        gs = "git status";
        gl = "git log --all --graph --pretty='%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09%C(Cyan)%an: %C(reset)%s %C(magenta)%d%C(reset)' --date=short -n 50";
        gi = "git init";
        ga = "git add";
        gc = "git commit";
        gf = "git fetch";
        gpl = "git pull";
        gp = "git push";
        gb = "git checkout";
        gcl = "git clone";
        grb = "git rebase";
        gm = "git merge";
        gwt = "git worktree";
      };
      syntaxHighlighting.enable = true;

      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-autosuggestions"
          "mattmc3/ez-compinit"
          "zdharma-continuum/fast-syntax-highlighting kind:defer"
          "zsh-users/zsh-completions kind:fpath path:src"
          "getantidote/use-omz" # handle OMZ dependencies
          "ohmyzsh/ohmyzsh path:lib" # load OMZ's library
          "ohmyzsh/ohmyzsh path:plugins/colored-man-pages" # load OMZ plugins
          "ohmyzsh/ohmyzsh path:plugins/magic-enter"
        ];
      };
    };

    programs.zoxide = {
      enable = true;
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        format = ''$battery$username$hostname$directory$git_branch$git_state$git_status$nix_shell$cmd_duration$line_break$character'';

        directory.read_only = " ";

        battery = {
          full_symbol = "•";
          charging_symbol = "⇡";
          discharging_symbol = "⇣";
        };

        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };

        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](bright-black) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };

        git_state = {
          format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
          style = "bright-black";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };

        nix_shell = {
          style = "bold blue";
          symbol = "";
          format = "[$symbol nix \\[$state\\] \\($name\\)]($style) ";
          impure_msg = "[⌽](bold dimmed red)";
          pure_msg = "[⌾](bold dimmed green)";
          unknown_msg = "[◌](bold dimmed yellow)";
        };
      };
    };

    programs.eza = {
      enable = true;
      colors = "always";
      icons = "always";
      git = true;
    };
  };
}
