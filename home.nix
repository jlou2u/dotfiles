{ config, pkgs, ... }:

let
  vimUtils = pkgs.callPackage ~/nixpkgs/pkgs/applications/editors/vim/plugins/vim-utils.nix { };

  vim-dichromatic = vimUtils.buildVimPlugin {
    pname = "vim-dichromatic";
    version = "2022-01-16";
    src = pkgs.fetchFromGitHub {
      owner = "romainl";
      repo = "vim-dichromatic";
      rev = "9765a72ce24ddae48afe12c316583a22c82ad812";
      sha256 = "0qzjfq2kgwwdxrblipysbmsdcd9xknfmlb27qrmg4yr0m59yz3nl";
    };
    meta.homepage = "https://github.com/romainl/vim-dichromatic/";
  };
in
{
  home.username = "justin";
  home.homeDirectory = if (pkgs.system == "x86_64-darwin") then "/Users/justin" else "/home/justin";

  home.packages = [

    # haskell
    pkgs.cabal-install
    pkgs.ghc
    pkgs.haskell-language-server
    pkgs.haskellPackages.hie-bios
    pkgs.haskellPackages.stack
    pkgs.haskellPackages.stylish-haskell

    # python
    (pkgs.python3Full.withPackages (ps: with ps; [
      black
      bokeh
      click
      cython
      flake8
      flask
      gensim
      hypothesis
      ipython
      isort
      jupyter
      matplotlib
      networkx
      numba
      numexpr
      pandas
      pip
      powerline
      psycopg2
      pyarrow
      pyls-isort
      pyls-memestra
      pylsp-rope
      python-lsp-black
      python-lsp-ruff
      python-lsp-server
      pymongo
      pyrsistent
      pytest
      requests
      scipy
      seaborn
      sqlalchemy
      statsmodels
      virtualenv
      websockets
      xarray
    ]))

    pkgs.ack
    pkgs.alacritty
    pkgs.any-nix-shell        # fish support for nix shell
    pkgs.bash
    pkgs.bat                  # A cat(1) clone with wings.
    pkgs.bottom               # alternative to htop & ytop
    pkgs.bzip2
    pkgs.coreutils
    pkgs.docker
    pkgs.docker-compose
    pkgs.drawio               # diagram design
    pkgs.eza                  # a better `ls`
    pkgs.fd
    pkgs.findutils
    pkgs.fzf
    pkgs.htop
    pkgs.inetutils
    pkgs.lazygit              # terminal git ui
    pkgs.ncdu                 # disk space info (a better du)
    pkgs.nerdfonts
    pkgs.nodejs
    pkgs.pwgen
    pkgs.ripgrep
    pkgs.sbt
    pkgs.silver-searcher
    pkgs.time
    pkgs.tree
    pkgs.vscode
    pkgs.xz
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {

      shell.program = "${pkgs.fish}/bin/fish";

      env = {
        "TERM" = "xterm-256color";
      };

      window.opacity = 0.95;

      font = {
        size = 16.0;

        # normal.family = "Source Code Pro for Powerline";
        # bold.family = "Source Code Pro for Powerline";
        # italic.family = "Source Code Pro for Powerline";
        normal.family = "D2CodingLigature Nerd Font";
        bold.family = "D2CodingLigature Nerd Font";
        italic.family = "D2CodingLigature Nerd Font";
      };

      cursor.style = "Beam";

      colors = {
        # Default colors
        primary = {
          background = "0x1b182c";
          foreground = "0xcbe3e7";
        };

        normal = {
          black =   "0x100e23";
          red =     "0xff8080";
          green =   "0x95ffa4";
          yellow =  "0xffe9aa";
          blue =    "0x91ddff";
          magenta = "0xc991e1";
          cyan =    "0xaaffe4";
          white =   "0xcbe3e7";
        };

        bright = {
          black =   "0x565575";
          red =     "0xff5458";
          green =   "0x62d196";
          yellow =  "0xffb378";
          blue =    "0x65b2ff";
          magenta = "0x906cff";
          cyan =    "0x63f2f1";
          white = "0xa6b3cc";
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
    profileExtra = ''
      [[ $- == *i* ]] && exec fish
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
    interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };

  programs.fzf = {
    enable = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Justin Lewis";
    userEmail = "justin.lewis@gmail.com";
    difftastic.enable = true;
    extraConfig = {
      diff.tool = "vimdiff";
      difftool.prompt = "false";
      log.date = "relative";
      format.pretty = "format:%C(auto,yellow)%h%C(auto,red)% G? %C(auto,cyan)%>(12,trunc)%ad %C(auto,bold blue)%<(7,trunc)%aN%C(auto,bold yellow)%gD%D %C(auto,reset)%s";
      core.fileMode = "false";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.ack-vim
      pkgs.vimPlugins.ale
      pkgs.vimPlugins.airline
      pkgs.vimPlugins.chadtree
      pkgs.vimPlugins.coc-css
      pkgs.vimPlugins.coc-explorer
      pkgs.vimPlugins.coc-fzf
      pkgs.vimPlugins.coc-git
      pkgs.vimPlugins.coc-highlight
      pkgs.vimPlugins.coc-html
      pkgs.vimPlugins.coc-json
      pkgs.vimPlugins.coc-python
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-vimlsp
      pkgs.vimPlugins.coc-yaml
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.fugitive
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.ghcid
      pkgs.vimPlugins.haskell-tools-nvim
      pkgs.vimPlugins.haskell-vim
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.nerdcommenter
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.papercolor-theme
      pkgs.vimPlugins.smartcolumn-nvim
      pkgs.vimPlugins.stylish-haskell
      pkgs.vimPlugins.supertab
      pkgs.vimPlugins.undotree
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.vim-autoformat
      pkgs.vimPlugins.vim-colorschemes
      pkgs.vimPlugins.vim-colors-solarized
      pkgs.vimPlugins.vim-cool
      pkgs.vimPlugins.vim-hoogle
      pkgs.vimPlugins.vim-lastplace
      pkgs.vimPlugins.vim-markdown
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-tmux-navigator
      pkgs.vimPlugins.vim-trailing-whitespace
      pkgs.vimPlugins.vimproc
      vim-dichromatic
    ];

    extraPackages = [
      pkgs.black
    ];

    coc.enable = true;

    extraConfig = ''

      set number

      noremap ; :

      map N Nzz
      map n nzz

      set expandtab
      set hls
      set ignorecase
      set incsearch
      set laststatus=2
      set listchars=eol:$
      set noshowmatch
      set nowrap
      set ruler
      set shortmess+=r
      set showcmd
      set showmode
      set cursorline

      " guess this is the best way to skip loading this plugin
      let g:loaded_matchparen=1

      let g:airline_theme='base16'
      let g:airline_powerline_fonts = 1
      let g:airline_skip_empty_sections = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#ale#enabled = 1

      nmap <space>e :CocCommand explorer --no-toggle<CR>

      set autoindent
      set smartindent
      set nocindent
      set expandtab
      set smarttab
      set tabstop=2
      set shiftwidth=2

      filetype plugin indent on
      syntax on

      set undodir=~/.vimhist/
      set undofile
      set undolevels=100
      set undoreload=1000

      let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
      let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
      let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
      let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
      let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
      let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
      let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
      let g:haskell_indent_disable = 1          " to disable indentation

      let g:syntastic_auto_jump = 0

      colorscheme dichromatic

      " use background color from terminal
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none

      " if hidden is not set, TextEdit might fail.
      set hidden

      " You will have bad experience for diagnostic messages when it's default 4000.
      set updatetime=300

      " Use <c-space> to trigger completion.
      inoremap <silent><expr> <c-space> coc#refresh()

      " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
      " Coc only does snippet and additional edit on confirm.
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

      " F5 to strip trailing whitespace
      nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

    '';

    extraLuaConfig = ''

      -- smartcolumn setup
      local config = {
        colorcolumn = "80",
        disabled_filetypes = { "help", "text", "markdown" },
        custom_colorcolumn = {},
        scope = "window",
      }
      require("smartcolumn").setup()

      -- indent-blankline setup
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    '';
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

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

}
