{ config, lib, pkgs, ... }:

let
  preferPath = command: default: pkgs.writeShellScript "${command}-wrapper" ''
    if command -v ${command}; then
        exec ${command} "$@"
    else
        exec ${default} "$@"
    fi
  '';
in
{
  programs.neovim-ide = {
    enable = true;
    settings = {
      vim = {
        configRC = builtins.readFile ./init.vim;
        viAlias = false;
        vimAlias = true;
        preventJunkFiles = true;
        customPlugins = with pkgs.vimPlugins; [
          multiple-cursors
          # . last command
          vim-repeat
          # cs"'
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
          # :G git command 
          vim-fugitive
          #vim-hcl
          vim-localvimrc

          vim-nix
          vim-pathogen
          # a universal set of defaults that (hopefully) everyone can agree on.
          vim-sensible
          # Automate infrastructure on any cloud
          # vim-terraform
          vim-tmux-navigator
          vim-twig
          vim-vue
          vimtex
          auto-save-nvim
          zoxide-vim

          nvim-jdtls
          #Debugging
          plenary-nvim
          nvim-dap
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
            #type = "nil";
          };
          dhall = !true;
          elm = !true;
          haskell = true;
          #sqlls = true;
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
          closeOnFileOpen = true;
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
        #scala = {
        #highlightMode = "treesitter";
        #};
        chatgpt = {
          enable = false;
        };
        # Displays availale keybinds
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
        # Leader ff search
        telescope = {
          enable = true;
        };
        markdown = {
          enable = true;
          glow.enable = true;
        };
        notifications.enable = true;
        dial.enable = true;
        spider = {
          enable = false;
          skipInsignificantPunctuation = true;
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
