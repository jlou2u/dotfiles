{ pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    historyLimit = 10000;
    extraConfig = ''

        # set -g default-command ${pkgs.zsh}/bin/zsh

        unbind C-b
        set -g prefix C-t
        bind C-t send-prefix

        unbind l

      # Pane switching unaware of vim splits
        bind h select-pane -L
        bind l select-pane -R
        bind j select-pane -D
        bind k select-pane -U
        bind -n 'C-\' select-pane -t :.+

      # Smart pane switching with awareness of vim splits
        bind h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
        bind j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
        bind k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
        bind l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
      # bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

        setw -g mode-keys vi
        bind-key -Tcopy-mode-vi 'v' send -X begin-selection
      # bind-key -Tcopy-mode-vi 'y' send -X copy-selection
        bind-key -Tcopy-mode-vi 'y' send -X copy-pipe 'xclip -in -selection primary'
        bind-key -Tcopy-mode-vi 'C-v' send -X rectangle-toggle

        unbind \;
        bind \; command-prompt

        bind r source-file ~/.tmux.conf

      # Bring back clear screen under tmux prefix
      # bind C-l send-keys 'C-l'

        set -g default-terminal "screen-256color"

      # List of plugins
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'

      # tmux-open - Key bindings
      #  In tmux copy mode:
      #        o - "open" a highlighted selection with the system default
      #            program. open for OS X or xdg-open for Linux.
      #   Ctrl-o - open a highlighted selection with the $EDITOR
      #  Shift-s - search the highlighted selection directly inside a search
      #            engine (defaults to google).
        set -g @plugin 'tmux-plugins/tmux-open'

        set -g @plugin 'tmux-plugins/tmux-yank'

        set -g @plugin 'jimeh/tmux-themepack'
        set -g @themepack 'double/orange'

        set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
      #updated block/orange to add to status-left
      #set -g status-left '#{prefix_highlight} | %a %Y-%m-%d %H:%M'
        set -g @prefix_highlight_fg 'white' # default is 'colour231'
        set -g @prefix_highlight_bg 'blue'  # default is 'colour04'
        set -g @prefix_highlight_show_copy_mode 'on'
        set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold' # default is 'fg=default,bg=yellow'

        set-option -g history-limit 10000

      # Other examples:
      # set -g @plugin 'github_username/plugin_name'
      # set -g @plugin 'git@github.com/user/plugin'
      # set -g @plugin 'git@bitbucket.com/user/plugin'

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
        run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
