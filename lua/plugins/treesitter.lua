require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"vim",
		"yaml",
	},
})
