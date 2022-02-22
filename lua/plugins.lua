local fn = vim.fn

-- boostrap packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

-- run PackerSync everytime plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

vim.cmd([[packadd packer.nvim]])

-- initialize plugins
return require('packer').startup(function(use)
    -- let packer manage itself
    use({'wbthomason/packer.nvim', opt = true})

    -- theme
    use("ishan9299/nvim-solarized-lua")

    -- commenting
    use("tpope/vim-commentary")

    -- session handling
    use('tpope/vim-obsession')
    use('dhruvasagar/vim-prosession')

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('lualine').setup() end
    }

    -- tabline
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require'tabline'.setup {
                enable = true,
                options = {show_filename_only = true}
            }
        end,
        requires = {
            {'hoob3rt/lualine.nvim'},
            {'kyazdani42/nvim-web-devicons', opt = true}
        }
    }

    -- blankline
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                char = "┊",
                buftype_exclude = {"terminal", "help"}
            }
        end
    })

    -- git
    use('tpope/vim-fugitive')
    use({
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    })

    -- autocompletion
    use({
        "ms-jpq/coq_nvim",
        branch = "coq",
        requires = {{'ms-jpq/coq.artifacts', branch = 'artifacts'}}
    })

    -- highlight current symbol
    use({"RRethy/vim-illuminate"})

    -- language server
    use({
        "neovim/nvim-lspconfig",
        config = function() require("plugins.lspconfig") end
    })

    use('williamboman/nvim-lsp-installer')

    -- treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        config = function() require('plugins.treesitter') end,
        run = ':TSUpdate'
    })

    -- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function() require('plugins.telescope') end
    })

    -- automatic pairs
    use({"Raimondi/delimitMate"})

    -- markdown preview
    use({'iamcco/markdown-preview.nvim'})

    -- terminal
    use({
        "akinsho/nvim-toggleterm.lua",
        config = function()
            require("toggleterm").setup({size = 32, open_mapping = [[<F4>]]})
        end
    })

    -- buffer closing
    use({"sar/bbye.nvim"})

    -- ansible filetype
    use({"pearofducks/ansible-vim"})

    if packer_bootstrap then require('packer').sync() end
end)
