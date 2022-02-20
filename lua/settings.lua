-- source file everytime it changes
vim.cmd([[
  augroup user_settings
    autocmd!
    autocmd BufWritePost settings.lua source <afile>
  augroup end
]])

vim.opt.number = true
