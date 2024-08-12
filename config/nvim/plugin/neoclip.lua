require('neoclip').setup({
    history = 1000,
    enable_persistent_history = false,
    length_limit = 1048576,
    continuous_sync = false,
    filter = nil,
    preview = true,
    prompt = nil,
    default_register = 'plus',
    enable_persistent_history = false,
    default_register_macros = 'q',
    enable_macro_history = false,
    content_spec_column = false,
    content_spec_column = false,
    on_paste = {
        set_reg = false,
    },
    on_replay = {
        set_reg = false,
    },
    keys = {
        telescope = {
            i = {
                select = '<cr>',
                paste = '<c-p>',
                paste_behind = '<c-;>',
                replay = '<c-q>',  -- replay a macro
                delete = '<c-d>',  -- delete an entry
                custom = {},
            },
            n = {
                select = '<cr>',
                paste = 'p',
                paste_behind = 'P',
                replay = 'q',
                delete = 'd',
                custom = {},
            },
        },
    },
})

vim.keymap.set('n', '<Leader>p', ':Telescope neoclip plus<CR>', {desc = "Search copy-history"})

