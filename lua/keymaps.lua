-- source file everytime it changes
vim.cmd([[
  augroup user_keymaps
    autocmd!
    autocmd BufWritePost keymaps.lua source <afile>
  augroup end
]])

local function nnoremap(key, command)
	vim.api.nvim_set_keymap("n",key,command, { noremap = true, silent = true })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move around windows
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Switch buffers
nnoremap("<TAB>", ":TablineBufferNext<CR>")
nnoremap("<S-TAB>", ":TablineBufferPrevious<CR>")

-- fugitive
nnoremap("<leader>G", ":tab G<CR>")

-- telescope
nnoremap("<leader>ff", "<Cmd>Telescope find_files theme=dropdown<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers theme=dropdown<CR>")
nnoremap("<leader>fg", "<Cmd>Telescope git_files theme=dropdown<CR>")
