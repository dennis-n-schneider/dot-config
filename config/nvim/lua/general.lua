-- disable netrw (nvim's default file explorer) for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.scrolloff = 3
vim.o.showmatch = true

vim.bo.undofile = true


if vim.env.SSH_TTY then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
    }
else
    vim.cmd([[
        if has("clipboard")
            set clipboard=unnamed
            if has("unnamedplus")
                set clipboard+=unnamedplus
            endif
        endif
    ]])
end

-- Disable Node.js provider.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = '/home/dns/.local/venv/nvim/bin/python'


-- Note: Running the check 1e6 times takes 1.1 seconds.
-- Execute current file.
vim.keymap.set('n', '<leader>o', ':wa | terminal ./%<CR>', {desc = "Execute file"})

