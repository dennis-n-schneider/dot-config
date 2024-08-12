require('lualine').setup({
    options = {
        theme = 'dracula-nvim',
        section_separators = {
            left = '',
            right = ''
        },
        component_separators = {
            left = '',
            right = ''
        },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
            }
        },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        'fzf',
        'nvim-tree',
    },
    globalstatus = true,
})
