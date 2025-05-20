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
        gl = "git log --oneline";
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
        "$schema" = "https://starship.rs/config-schema.json";
        
        format = "[](red)$os$username[](bg:peach fg:red)$directory[](bg:yellow fg:peach)$git_branch$git_status[](fg:yellow bg:green)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:green bg:sapphire)$conda[](fg:sapphire bg:lavender)$time[ ](fg:lavender)$cmd_duration$line_break$character";

        palette = "catppuccin_mocha";
        
        os = {
          disabled = false;
          style = "bg:red fg:crust";

          symbols = {
            NixOS = "";
          };
        };

        username = {
          show_always = true;
          style_user = "bg:red fg:crust";
          style_root = "bg:red fg:crust";
          format = "[ $user ]($style)";
        };

        directory = {
          style = "bg:peach fg:crust";
          format = "[ $path ]($style)";
          truncation_length = 1;
          truncation_symbol = "";

          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = "󰝚 ";
            "Pictures" = " ";
            "Developer" = "󰲋 ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:yellow";
          format = "[[ $symbol $branch ](fg:crust bg:yellow)]($style)";
        };

        git_status = {
          style = "bg:yellow";
          format = "[[($all_status$ahead_behind )](fg:crust bg:yellow)]($style)";
        };
        
        nodejs = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        rust = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        golang = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        php = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        kotlin = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        haskell = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:crust bg:green)]($style)";
        };

        python = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version)(\(#$virtualenv\)) ](fg:crust bg:green)]($style)";
        };

        docker_context = {
          symbol = " ";
          style = "bg:sapphire";
          format = "[[ $symbol( $context) ](fg:crust bg:sapphire)]($style)";
        };

        conda = {
          symbol = "  ";
          style = "fg:crust bg:sapphire";
          format = "[$symbol$environment ]($style)";
          ignore_base = false;
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:lavender";
          format = "[[  $time ](fg:crust bg:lavender)]($style)";
        };

        line_break.disabled = true;

        character = {
          disabled = false;
          success_symbol = "[❯](bold fg:green)";
          error_symbol = "[❯](bold fg:red)";
          vimcmd_symbol = "[❮](bold fg:green)";
          vimcmd_replace_one_symbol = "[❮](bold fg:lavender)";
          vimcmd_replace_symbol = "[❮](bold fg:lavender)";
          vimcmd_visual_symbol = "[❮](bold fg:yellow)";
        };

        cmd_duration = {
          show_milliseconds = true;
          format = " in $duration ";
          style = "bg:lavender";
          disabled = false;
          show_notifications = true;
          min_time_to_notify = 45000;
        };

        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dr";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
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
