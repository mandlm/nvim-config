require('nvim-treesitter.configs').setup({
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    indent = {enable = true},
    ensure_installed = {
        "bash", "c", "cpp", "css", "dockerfile", "html", "javascript", "json",
        "latex", "lua", "markdown", "python", "rust", "svelte", "toml", "tsx",
        "typescript", "vim", "vue", "yaml"
    }
})
