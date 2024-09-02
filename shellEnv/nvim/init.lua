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

-- function on_lsp_attach(client, bufnr)
-- 	local opts = { noremap=true, silent=true }
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- end

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

  local tree_api = require("nvim-tree.api").tree
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not directory and not no_name then
    tree_api.change_root(vim.fs.dirname(data.file))
    return
  end
  if directory then
    -- change to the directory
    tree_api.change_root(data.file)
    -- open the tree
    tree_api.open()
  end

end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


------------------------------------------enhanceAction---------------------------------------------
local function peekOrHover()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if winid then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local keys = {'a', 'i', 'o', 'A', 'I', 'O', 'gd', 'gr'}
        for _, k in ipairs(keys) do
            -- Add a prefix key to fire `trace` action,
            -- if Neovim is 0.8.0 before, remap yourself
            vim.keymap.set('n', k, '<CR>' .. k, {noremap = false, buffer = bufnr})
        end
    else
        -- nvimlsp
        vim.lsp.buf.hover()
    end
end

local function goPreviousClosedAndPeek()
    require('ufo').goPreviousClosedFold()
    require('ufo').peekFoldedLinesUnderCursor()
end

local function goNextClosedAndPeek()
    require('ufo').goNextClosedFold()
    require('ufo').peekFoldedLinesUnderCursor()
end

require('ufo').setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_ft = {'imports', 'comment'},
    preview = {
        win_config = {
            border = {'', '─', '', '', '', '─', '', ''},
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
        }
    },
    fold_virt_text_handler = handler,
    enhanceAction = peekOrHover,
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

-- require('fold-preview').setup({
--          -- Your configuration goes here.
--          auto = 400
-- })
M = {}
local api = vim.api
local fn = vim.fn
api.nvim_create_autocmd('CursorMoved', {
         callback = function()
            local curwin = api.nvim_get_current_win()
            local line = api.nvim_win_get_cursor(curwin)[1]

            local function callback()
               if M.timer then
                  M.timer:stop()
                  M.timer:close()
                  M.timer = nil
               end

               if curwin == api.nvim_get_current_win()
                  and line == api.nvim_win_get_cursor(curwin)[1]
                  and fn.foldclosed('.') ~= -1
               then
		  peekOrHover()
               end
            end

            if M.timer then
               M.timer:stop()
            else
               M.timer = vim.loop.new_timer()
            end
            M.timer:start(400, 0, vim.schedule_wrap(callback))
         end
      })

-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile', 'CMakeList.txt', 'flake.nix', 'package.json', 'Cargo.lock'}

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then return end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
