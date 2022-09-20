{ pkgs, ... }:
{
  environment.variables = { EDITOR = "nvim"; };

  environment.systemPackages = with pkgs; [
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            indentLine
            vim-lastplace
            vim-nix
            nvim-web-devicons
            nvim-tree-lua

            nvim-lspconfig
            nvim-compe

            bufferline-nvim
            galaxyline-nvim

            (nvim-treesitter.withPlugins (_: tree-sitter.allGrammars))
          ];
          opt = [ ];
        };
        customRC = ''
          " your custom vimrc
          luafile /home/kaminari/nixos/config/nvim/settings.lua
          luafile /home/kaminari/nixos/config/nvim/treesitter.lua
          luafile /home/kaminari/nixos/config/nvim/tree.lua
          luafile /home/kaminari/nixos/config/nvim/bufferline.lua
          luafile /home/kaminari/nixos/config/nvim/lsp.lua
          luafile /home/kaminari/nixos/config/nvim/neorg.lua

          set nocompatible
          set backspace=indent,eol,start
          " ...
        '';
      };
    }
    )
  ];
}
