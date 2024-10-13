zen = require('zen-mode')

zen.setup({
    window = {
        backdrop=1,
        options = {
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            list = false,
        },
    },
    plugins = {
        options = {
            ruler = false,
            showcmd = false,
        },
        gitsigns = { enabled = true },
        todo = { enabled = false },
        kitty = {
            enabled = false,
        }
    },
    on_open = function(win)
        vim.cmd("LspStop")
    end,
    on_close = function()
        vim.cmd("LspStart")
    end,
})

vim.keymap.set('n', '<leader>zz', zen.toggle, {noremap = true, silent = true, desc = "Start Zen-mode"})
