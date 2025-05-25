{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.tmux;
in {
  options.lily.tmux = {
    enable = lib.mkEnableOption "activate tmux";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      keyMode = "vi";
      prefix = "C-a";
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.tmux-which-key
        tmuxPlugins.vim-tmux-navigator
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
            # set -g @catppuccin_window_status_style "rounded"
            set -g status-bg default
            set -g status-style bg=default

            set -g @catppuccin_status_background "none"
          '';
        }
      ];
      extraConfig = ''
        set -g @plugin 'tmux-plugins/tpm'

        run '~/.tmux/plugins/tmux/catppuccin.tmux'

        set -sg terminal-overrides ",*:RGB"
        set -g renumber-windows on
        set -g escape-time 0
        set -g pane-border-lines simple
        set -g pane-border-style fg=white
        set -g pane-active-border-style fg=white,bright

        bind v split-window -h
        bind s split-window -v
        bind q kill-pane

        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"

        bind -n C-h if-shell "[[ $(tmux display -p '#{pane_current_command}') =~ (n?vim|nvim) ]]" "send-keys C-h" "select-pane -L"
        bind -n C-j if-shell "[[ $(tmux display -p '#{pane_current_command}') =~ (n?vim|nvim) ]]" "send-keys C-j" "select-pane -D"
        bind -n C-k if-shell "[[ $(tmux display -p '#{pane_current_command}') =~ (n?vim|nvim) ]]" "send-keys C-k" "select-pane -U"
        bind -n C-l if-shell "[[ $(tmux display -p '#{pane_current_command}') =~ (n?vim|nvim) ]]" "send-keys C-l" "select-pane -R"

        run '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };
}
