-- source file everytime it changes
vim.cmd([[
  augroup user_options
  autocmd!
  autocmd BufWritePost options.lua source <afile>
  augroup end
]])

-- termguicolors
vim.opt.termguicolors = true

-- line numbers
vim.opt.number = true

-- tabwidth
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- indent with spaces
vim.opt.expandtab = true

-- scroll offset
vim.opt.scrolloff = 4

-- don't warp lines
vim.opt.wrap = false

-- split to right/below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- presistent undo
vim.opt.undofile = true

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- preview commands
vim.opt.inccommand = "split"

-- set cursorline in active window
vim.cmd([[
    augroup CursorLine
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
]])

-- coq.nvim
vim.g.coq_settings = {
    auto_start = "shut-up",
    keymap = {
        jump_to_mark = "",      -- prevent <C-h> remapping
    },
}
