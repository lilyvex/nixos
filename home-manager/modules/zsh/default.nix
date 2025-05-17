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
    programs.starship.enable = true;
    programs.eza = {
      enable = true;
      colors = "always";
      icons = "always";
      git = true;
    };
  };
}
