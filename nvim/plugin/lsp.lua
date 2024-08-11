local lspconfig = require("lspconfig")

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)
--
--
-- Rope alternative
require('refactoring').setup()

local on_attach = function(client, bufnr)
    local bufmap = function(mode, lhs, rhs)
        local opts = {noremap = true, silent = true, buffer = true}
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    -- Jump to the definition
    bufmap('n', 'gd', vim.lsp.buf.definition)
    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    -- Renames all references to the symbol under the cursor
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<leader>rm', ":Refactor extract ")
    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    -- Move to the previous diagnostic-
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

lspconfig.pyright.setup {
    on_attach = on_attach,
    root_dir = require('lspconfig').util.find_git_ancestor
}

lspconfig.ltex.setup {
    on_attach = on_attach,
    root_dir = require('lspconfig').util.find_git_ancestor,
    ltex = {
        language = "en-GB"
    }
}

-- cmp
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end
    },

    sources = { -- Sources for completion.
      {name = 'snippy' }, -- Available snippets.
      {name = 'nvim_lsp_signature_help'},
      {name = 'nvim_lsp'},
      {name = 'path'}, -- Autocomplete file paths.
      {name = 'buffer'}, -- Words found in current buffer.
    },

    -- Controls the appearance and settings for the documentation window.
    window = {
        documentation = cmp.config.window.bordered()
    },

    experimental = {
        ghost_text = true,
    },

    formatting = {
        fields = {"abbr", "menu"},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = ' ',
                snippy = '󰁨 ',
                buffer = ' ',
                path = ' ',
                nvim_lsp_signature_help = " ",
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },

    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-j>'] = cmp.mapping.select_next_item(select_opts),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

cmp.setup.cmdline({':'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {
            { name = "path" }
        }, 
        {
            { name = "cmdline",
                option = {
                    ignore_cmds = { "Man", "!" }
                }
            }
        })
})


local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
    },
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        style = "minimal",
        focusable = false,
    },
    update_in_insert = true,
})

