{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.ack-vim
      pkgs.vimPlugins.ale
      pkgs.vimPlugins.airline
      pkgs.vimPlugins.barbecue-nvim
      pkgs.vimPlugins.chadtree
      pkgs.vimPlugins.coc-css
      pkgs.vimPlugins.coc-explorer
      pkgs.vimPlugins.coc-fzf
      pkgs.vimPlugins.coc-git
      pkgs.vimPlugins.coc-highlight
      pkgs.vimPlugins.coc-html
      pkgs.vimPlugins.coc-json
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-vimlsp
      pkgs.vimPlugins.coc-yaml
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.diffview-nvim
      pkgs.vimPlugins.dressing-nvim
      pkgs.vimPlugins.fugitive
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.ghcid
      pkgs.vimPlugins.haskell-tools-nvim
      pkgs.vimPlugins.haskell-vim
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.kanagawa-nvim
      pkgs.vimPlugins.neogit
      pkgs.vimPlugins.nerdcommenter
      pkgs.vimPlugins.noice-nvim
      pkgs.vimPlugins.nvim-dap
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-notify
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.papercolor-theme
      pkgs.vimPlugins.refactoring-nvim
      pkgs.vimPlugins.smartcolumn-nvim
      pkgs.vimPlugins.stylish-haskell
      pkgs.vimPlugins.supertab
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.tokyonight-nvim
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
      pkgs.vimPlugins.vimspector
      pkgs.vimPlugins.which-key-nvim
    ];

    extraPackages = [
      pkgs.black
      pkgs.clang
      pkgs.cmake-lint
      pkgs.efm-langserver
      pkgs.hlint
      pkgs.imagemagick
      pkgs.lazygit
      pkgs.lua51Packages.lua
      pkgs.lua-language-server
      pkgs.luajit
      pkgs.manix
      pkgs.neocmakelsp
      pkgs.nginx-language-server
      pkgs.nil
      pkgs.nixd
      pkgs.nixfmt-rfc-style
      pkgs.poppler_utils
      pkgs.pyright
      pkgs.tectonic
      pkgs.tree-sitter
    ];

    extraPython3Packages =
      pyPkgs: with pyPkgs; [
        black
        python-lsp-black
        python-lsp-server
        pylatexenc
        pynvim
        jupyter-client
        cairosvg # for image rendering
        pnglatex # for image rendering
        plotly # for image rendering
        numpy
        matplotlib
        sympy
        pyperclip
        ipython
        ipykernel
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
          set signcolumn=yes
          set scrolloff=10

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

          " colorscheme dichromatic
          colorscheme 3dglasses

          " use background color from terminal
          highlight Normal ctermbg=none
          highlight NonText ctermbg=none

          " if hidden is not set, TextEdit might fail.
          set hidden

          " You will have bad experience for diagnostic messages when it's default 4000.
          set updatetime=50

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

            -- telescope setup
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

            -- neogit setup
            local neogit = require('neogit')
            neogit.setup {}

            -- lsp setup
            require'lspconfig'.pylsp.setup{
              settings = {
                pylsp = {
                  plugins = {
                    pycodestyle = {
                    },
                    black = {
                      enabled = true
                    }
                  }
                }
              }
            }

            -- barbecue setup
            require('barbecue').setup()

            vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
              local mode = vim.api.nvim_get_mode().mode
              if vim.bo.modified == true and mode == 'n' then
                  vim.cmd('lua vim.lsp.buf.format()')
              else
              end
            end
      })
    '';
  };
}
