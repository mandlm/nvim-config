local coq = require("coq")
local lsp_installer = require("nvim-lsp-installer")

local nvim_runtime_path = vim.split(package.path, ';')
table.insert(nvim_runtime_path, "lua/?.lua")
table.insert(nvim_runtime_path, "lua/?/init.lua")

local language_servers = {
    "ansiblels", "bashls", "dockerls", "efm", "eslint", "html", "pyright",
    "rust_analyzer", "sumneko_lua", "svelte", "taplo", "tsserver", "volar"
}

for _, server_name in pairs(language_servers) do
    local server_found, server = lsp_installer.get_server(server_name)
    if server_found and not server:is_installed() then
        print("Installing " .. server_name)
        server:install()
    end

end

local extra_server_opts = {
    ["efm"] = function(opts)
        opts.filetypes = {
            "lua", "html", "markdown", "typescript", "typescriptreact"
        }
        opts.init_options = {documentFormatting = true}
        opts.settings = {
            rootMarkers = {".git/"},
            languages = {
                lua = {{formatCommand = "lua-format -i", formatStdin = true}},
                html = {
                    {formatCommand = "yarn run --silent prettier --parser html"}
                },
                typescript = {
                    {
                        formatCommand = "yarn run --silent prettier --parser typescript"
                    }
                },
                typescriptreact = {
                    {
                        formatCommand = "yarn run --silent prettier --parser typescript"
                    }
                },
                markdown = {
                    {
                        formatCommand = "yarn run --silent prettier --parser markdown"
                    }
                }
            }
            -- prettier-parser
            -- flow|babel|babel-flow|babel-ts|typescript|espree|meriyah|css|
            -- less|scss|json|json5|json-stringify|graphql|markdown|mdx|vue|yaml|glimmer|html|angular|lwc
        }
    end,
    ["sumneko_lua"] = function(opts)
        opts.settings = {
            Lua = {
                runtime = {version = 'LuaJIT', path = nvim_runtime_path},
                diagnostics = {globals = {'vim'}},
                workspace = {library = vim.api.nvim_get_runtime_file("", true)},
                telemetry = {enable = false}
            }
        }
    end
}

local function custom_on_attach(client, buffer_nr)
    -- onmifunc
    vim.api.nvim_buf_set_option(buffer_nr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Helper function
    local opts = {noremap = true, silent = true}
    local function bufnnoremap(key, action)
        vim.api.nvim_buf_set_keymap(buffer_nr, 'n', key, action, opts)
    end

    -- Inspect function
    bufnnoremap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
    bufnnoremap("<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")

    -- Navigation
    bufnnoremap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    bufnnoremap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    bufnnoremap("gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
    bufnnoremap("gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
    bufnnoremap("ga", "<Cmd>Telescope lsp_code_actions theme=cursor<CR>")

    -- Rename all references of symbol
    bufnnoremap("<leader>R", "<Cmd>lua vim.lsp.buf.rename()<CR>")

    -- Navigate diagnostics
    bufnnoremap("<C-n>", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
    bufnnoremap("<C-p>", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")

    -- Show line diagnostics
    bufnnoremap("<leader>d",
                '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

    -- Open local diagnostics in local list
    bufnnoremap("<leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>")

    -- Open all project diagnostics in quickfix list
    bufnnoremap("<leader><C-d>", "<Cmd>lua vim.diagnostic.setqflist()<CR>")

    -- disable conflicting formatters
    if client.name == "tsserver" or client.name == "html" then
        client.resolved_capabilities.document_formatting = false
    end

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

    -- vim-illuminate
    require("illuminate").on_attach(client)
end

lsp_installer.on_server_ready(function(server)
    local opts = coq.lsp_ensure_capabilities({
        on_attach = custom_on_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities()
    })

    if extra_server_opts[server.name] then
        extra_server_opts[server.name](opts)
    end

    server:setup(opts)
end)
