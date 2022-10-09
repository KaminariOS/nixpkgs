{ config, lib, pkgs, ... }:

{
  programs.neovim-ide = {
    enable = true;
    settings = {
      vim = {
        configRC =''
            set cursorline
            set shell=fish
            " Remap splits navigation to just CTRL + hjkl
            nnoremap <C-h> <C-w>h
            nnoremap <C-j> <C-w>j
            nnoremap <C-k> <C-w>k
            nnoremap <C-l> <C-w>l

            " Make adjusing split sizes a bit more friendly
            noremap <silent> <C-Left> :vertical resize +3<CR>
            noremap <silent> <C-Right> :vertical resize -3<CR>
            noremap <silent> <C-Up> :resize +3<CR>
            noremap <silent> <C-Down> :resize -3<CR>
            
            set clipboard+=unnamedplus
            set autoread
            set autowriteall
            set undofile
            set undodir=~/.config/nvim
            augroup jump_last_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
augroup END

        '';
        viAlias = true;
        vimAlias = true;
        customPlugins = with pkgs.vimPlugins; [
          multiple-cursors
          vim-repeat
          vim-surround
        ];
        lsp = {
          enable = true;
          folds = true;
          formatOnSave = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          nvimCodeActionMenu.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
          rust.enable = true;
          nix = true;
          dhall = true;
          elm = true;
          haskell = true;
          sql = true;
          python = false;
          clang = true;
          ts = false;
          go = true;
        };
        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          lspkind.enable = true;
          indentBlankline = {
            enable = true;
            fillChar = "";
            eolChar = "";
            showCurrContext = true;
          };
          cursorWordline = {
            enable = true;
            lineTimeout = 0;
          };
        };
        statusline.lualine = {
          enable = true;
          theme = "nightfox";
        };
        theme = {
          enable = true;
          name = "nightfox";
          style = "nightfox";
          transparency = true;
        };
        autopairs.enable = true;
        autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };
        filetree.nvimTreeLua = {
          enable = true;
          hideDotFiles = false;
          hideFiles = [ "node_modules" ".cache" ];
        };
        hop.enable = true;
        todo.enable = true;
        tabline.nvimBufferline.enable = true;
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
        };
        scala = {
          highlightMode = "treesitter";
        };
        keys = {
          enable = true;
          whichKey.enable = true;
        };
        comments = {
          enable = true;
          type = "nerdcommenter";
        };
        shortcuts = {
          enable = true;
        };
        telescope = {
          enable = true;
        };
        markdown = {
          enable = true;
          glow.enable = true;
        };
        git = {
          enable = true;
          gitsigns.enable = true;
        };
      };
    };
  };
}
