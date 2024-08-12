vim.o.timeout = true
vim.o.timeoutlen = 500

local wk = require("which-key")

wk.setup({
    plugins = {
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
        }
    }
})

wk.add({
    { "<leader>f", group="File" },
    { "<leader>c", group="Comments" },
    { "<leader>h", group="Git" },
    { "<leader>r", group="Reformat" },
    { "<leader>t", group="Tree" },
    { "<leader>z", group="Zen" },
})

