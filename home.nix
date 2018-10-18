{ pkgs, ... }:

let
  my_vim_configurable = pkgs.vim_configurable.override {
    python = pkgs.python36Full;
  };

in

{
  home.sessionVariables.EDITOR = "vim";
  home.sessionVariables.PAGER = "less";
  home.file.".vimrc".source = ./vimrc;

  home.packages = [
    pkgs.ack
    pkgs.atool
    pkgs.bashCompletion
    pkgs.bzip2
    pkgs.cifs-utils
    pkgs.coreutils
    pkgs.docker_compose
    pkgs.fd
    pkgs.findutils
    pkgs.fortune
    pkgs.gawk
    pkgs.gcc
    pkgs.gdb
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
    pkgs.powerline-fonts
    pkgs.powertop
    pkgs.procps
    pkgs.python36Full
    pkgs.python36Packages.ipython
    pkgs.python36Packages.pip
    pkgs.python36Packages.powerline
    pkgs.python36Packages.virtualenv
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
    pkgs.tmux
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
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude __pycache__'
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
      set fish_greeting
      set -gx CONDA_LEFT_PROMPT 1
      conda activate
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

  /*
  programs.vim = {
    enable = true;
    settings.number = true;
    plugins = [
      "ack-vim"
      "flake8-vim"
      "fzf-vim"
      "python-mode"
      "vim-airline"
      "vim-airline-themes"
      "vim-fugitive"
      "vim-gitgutter"
      "vim-ipython"
      "vim-tmux-navigator"
    ];
    extraConfig = ''
      set nocompatible
      colorscheme darkblue
      noremap ; :
      noremap : ;
      map N Nzz
      map n nzz
      set hls
      set ruler
      set laststatus=2
      set shortmess+=r
      set showmode
      set showcmd
      set listchars=eol:$
      set nowrap
      set expandtab
      set incsearch
      set rtp+=~/.nix-profile/bin/fzf
      au FileType python setlocal colorcolumn=80 expandtab
      autocmd BufWritePost *.py call Flake8()
      nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
      let g:pymode_python = 'python3'
      " let g:flake8_cmd="/opt/miniconda3/bin/flake8"
      call vam#ActivateAddons(["vim-flake8"])
    '';
  };
  */

}
