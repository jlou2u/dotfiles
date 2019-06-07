{ pkgs, ... }:

let
  my_vim_configurable = pkgs.vim_configurable.override {
    python = pkgs.python36Full;
  };

in

{
  home.sessionVariables.BAT_THEME = "GitHub";
  home.sessionVariables.EDITOR = "vim";
  home.sessionVariables.LOCALE_ARCHIVE = pkgs.glibcLocales + "/lib/locale/locale-archive";
  home.sessionVariables.PAGER = "less";
  home.sessionVariables.PYTHONDONTWRITEBYTECODE = "true";

  home.file.".vimrc".source = ./vimrc;
  home.file.".docker/config.json".source = ./docker_config.json;
  home.file.".config/flake8".source = ./flake8;

  home.packages = [
    pkgs.ack
    pkgs.atool
    pkgs.bashCompletion
    pkgs.bat
    pkgs.bzip2
    # pkgs.cifs-utils
    pkgs.coreutils
    pkgs.docker_compose
    pkgs.fd
    pkgs.findutils
    pkgs.fortune
    pkgs.gawk
    pkgs.gcc
    pkgs.gdb
    pkgs.glibcLocales
    pkgs.gnugrep
    pkgs.gnumake
    pkgs.gnused
    pkgs.gnutar
    pkgs.go
    pkgs.gzip
    pkgs.htop
    pkgs.inetutils
    pkgs.jdk8
    pkgs.ncat
    pkgs.ncdu
    pkgs.nmap
    pkgs.nodejs
    pkgs.mc
    pkgs.openssh
    pkgs.powerline-rs
    pkgs.powerline-fonts
    pkgs.powertop
    pkgs.procps
    pkgs.python36Full
    pkgs.python36Packages.black
    pkgs.python36Packages.flake8
    pkgs.python36Packages.ipython
    pkgs.python36Packages.pip
    pkgs.python36Packages.powerline
    pkgs.python36Packages.virtualenv
    pkgs.pwgen
    pkgs.ripgrep
    pkgs.rsync
    pkgs.sbt
    pkgs.silver-searcher
    pkgs.source-code-pro
    pkgs.sqlite
    pkgs.tcpdump
    pkgs.telnet
    pkgs.terminus_font
    pkgs.terminus_font_ttf
    pkgs.time
    pkgs.tldr
    pkgs.tmux
    pkgs.tree
    pkgs.unzip
    pkgs.wget
    pkgs.xz
    pkgs.zip
    my_vim_configurable
  ];

  programs.command-not-found.enable = false;  # requires nixos?

  programs.bash = {
    enable = true;
    profileExtra = ''
      . ${pkgs.fzf}/share/fzf/completion.bash
      . ${pkgs.fzf}/share/fzf/key-bindings.bash
      # export FZF_DEFAULT_COMMAND='fd --type f'
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude __pycache__ --exclude .vimbackup --exclude .vimtmp'
      shopt -s direxpand
      stty -ixon
      exec $HOME/.nix-profile/bin/fish
    '';
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
    ];
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      . /opt/miniconda3/etc/fish/conf.d/conda.fish
    '';
    interactiveShellInit = ''
      # function fish_prompt
      #   powerline-rs --shell bare $status
      # end
      set fish_greeting
      set -gx CONDA_LEFT_PROMPT 1

      function print_qal_funcs
        cat $argv | perl -lne 's/\b([a-zA-Z0-9]+)\(/\n#FUNC\1END/g; print' | grep '#FUNC' | sed -e 's/#FUNC//' | perl -lne 's/(.+)END.+/\1/g; print' | sort -u | xargs -n1 echo "$argv,"
      end

      # exa is better
      alias ls="exa"

      # default to following symlinks
      alias ag="ag -f"
    '';
  };

  programs.fzf = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Justin Lewis";
    userEmail = "justin.lewis@gmail.com";
    extraConfig = ''
        [gc]
          autoDetach = false
        [diff]
          tool = vimdiff
        [difftool]
          prompt = false
        [alias]
          d = difftool
        [log]
          date = relative
        [format]
          pretty = format:%C(auto,yellow)%h%C(auto,red)% G? %C(auto,cyan)%>(12,trunc)%ad %C(auto,bold blue)%<(7,trunc)%aN%C(auto,bold yellow)%gD%D %C(auto,reset)%s
          #pretty = format:%C(auto,yellow)%h%C(auto,red)% G? %C(auto,cyan)%>(12,trunc)%ad %C(auto,bold blue)%<(7,trunc)%aN%C(auto,reset)%s%C(auto,bold yellow)% gD% D
        [core]
          fileMode = false
    '';
  };

  programs.home-manager = {
    enable = true;
    /*path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;*/
    path = "/home/jlewis/code/home-manager";
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    historyLimit = 10000;
    extraConfig = ''
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
      bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

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
