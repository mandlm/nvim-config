local fn = vim.fn
local cmd = vim.cmd

-- Boostrap Packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone','https://github.com/wbthomason/packer.nvim', install_path})
end

-- Rerun PackerSync everytime plugins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Initialize pluggins
return require('packer').startup(function(use)
  -- Let Packer manage itself
  use('wbthomason/packer.nvim')

  -- Themes
  use('altercation/vim-colors-solarized')

  -- session handling
  use('tpope/vim-obsession')
  use('dhruvasagar/vim-prosession')

  -- git commands
  use('tpope/vim-fugitive')

  if packer_bootstrap then
    require('packer').sync()
  end
end)

