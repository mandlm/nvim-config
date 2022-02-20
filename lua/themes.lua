-- source file everytime it changes
vim.cmd([[
  augroup user_theme_config
    autocmd!
    autocmd BufWritePost themes.lua source <afile>
  augroup end
]])

vim.cmd [[colorscheme solarized]]
vim.opt.background = 'dark'
