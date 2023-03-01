{ config, lib, pkgs, ... }:

let
  preferPath = command: default: pkgs.writeShellScript "${command}-wrapper" ''
    if command -v ${command}; then
        exec ${command} "$@"
    else
        exec ${default} "$@"
    fi
  ''; in
{
  programs.neovim-ide = {
    enable = true;
    settings = {
      vim = {
        configRC = builtins.readFile ./init.vim;
        viAlias = true;
        vimAlias = true;
        preventJunkFiles = true;
        customPlugins = with pkgs.vimPlugins; [
          multiple-cursors
          vim-repeat
          vim-surround

          
          lsp-colors-nvim
          lsp_extensions-nvim
          nvim-compe
          nvim-lspconfig
          rust-tools-nvim
          rust-vim
          vim-airline
          vim-cpp-enhanced-highlight
          vim-fish
          vim-fugitive
          vim-hcl
          vim-localvimrc

          vim-nix
          vim-pathogen
          vim-sensible
          vim-terraform
          vim-tmux-navigator
          vim-twig
          vim-vue
          vimtex
        ];
        useSystemClipboard = true;
        neovim.package = pkgs.neovim-nightly;
        lsp = {
          enable = true;
          folds = true;
          formatOnSave = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          nvimCodeActionMenu.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
          rust.enable = !true;
          nix = {
            enable = true;
            type = "nil";
          };
          dhall = !true;
          elm = !true;
          haskell = true;
          sql = true;
          python = true;
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
          openOnSetup = false;
          hideDotFiles = false;
          hideFiles = [ "node_modules" ".cache" ];
        };
        neoclip.enable = true;
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
        surround = {
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


  xdg.configFile."nvim/config.lua".source = pkgs.substituteAll {
    src = ./init.lua;
    pyrightLangserver = preferPath "pyright-langserver" "${pkgs.pyright}/bin/pyright-langserver";
    rustAnalyzer = preferPath "rust-analyzer" "${pkgs.rust-analyzer}/bin/rust-analyzer";
  };
}
