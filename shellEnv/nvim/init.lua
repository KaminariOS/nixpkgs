-- https://stackoverflow.c om/a/27028488
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function on_lsp_attach(client, bufnr)
	local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

-- local rust_tools_nvim = {
--     tools = {
--     },
--
--     server = {
--         cmd = { "@rustAnalyzer@" },
--         on_attach = on_lsp_attach,
--         settings = {
--             ["rust-analyzer"] = {
--                 checkOnSave = {
--                     -- 	command = { "clippy" },
--                     extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
--                 },
--             },
--         },
--     },
-- }

-- if os.execute('command -v cargo-clippy') == 0 then
--     rust_tools_nvim.server.settings["rust-analyzer"].checkOnSave.command = "clippy"
-- end

-- require('rust-tools').setup(rust_tools_nvim)


require'lspconfig'.jdtls.setup{
    on_attach = on_lsp_attach,
}

require'lspconfig'.cmake.setup{}
require'lspconfig'.taplo.setup{}
require'lspconfig'.texlab.setup{
    on_attach = on_lsp_attach,
}
require'lspconfig'.svelte.setup{
    on_attach = on_lsp_attach,
}
require'lspconfig'.marksman.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.jsonls.setup{
    cmd = { "vscode-json-languageserver", "--stdio" },
}
require'lspconfig'.yamlls.setup{}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not directory and not no_name then
    vim.cmd.cd(vim.fs.dirname(data.file))
    return
  end
  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)
  -- open the tree
  require("nvim-tree.api").tree.open()
  end

end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = false,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme nightfox")
