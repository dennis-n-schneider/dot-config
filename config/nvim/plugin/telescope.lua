local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
    defaults = {
        -- Plugin-local mappings
        mappings = {
            i = {
                -- Same behaviour as coc
                ['<C-J>'] = actions.move_selection_next,
                ['<C-K>'] = actions.move_selection_previous,
                -- The following mappings are default, but are listed explicitly since I use them a lot.
                -- Same behaviour as nvim-tree
                ['<C-X>'] = actions.select_horizontal,
                ['<C-V>'] = actions.select_vertical,
                ['<C-T>'] = actions.select_tab,
            }
        },
    },
    pickers = {
        builtin = {
            theme = 'ivy',
        },
        git_commits = {
            theme = 'ivy',
        },
        find_files = {
            theme = 'ivy',
        },
        live_grep = {
            theme = 'ivy',
        },
    },
    extensions = {
        repo = {
            list = {
                fd_opts = {
                    "--no-ignore-vcs",
                },
                search_dirs = {
                    "~/Documents/dev",
                    "~/.config"
                },
            },
        },
    }
})

telescope.load_extension('fzf')
telescope.load_extension('remote-sshfs')
-- telescope.load_extension('zoxide')
telescope.load_extension('repo')
telescope.load_extension('neoclip')
telescope.load_extension('harpoon')

local builtin = require('telescope.builtin')
local connections = require('remote-sshfs.connections')
local api = require('remote-sshfs.api')

-- Choose from all telescope-options
vim.keymap.set('n', '<leader>fa', builtin.builtin, {noremap = true, silent = true, desc = "Show all telescope options"})

-- Search repos
vim.keymap.set('n', '<leader>fr', telescope.extensions.repo.list, {noremap = true, silent = true, desc = "List projects"})

-- Search through git commits
vim.keymap.set('n', '<leader>fc', builtin.git_commits, {noremap = true, silent = true, desc = "Show git commits"})

-- Search through files in cwd
vim.keymap.set('n', '<leader>ff', 
    function()
        if connections.is_connected() then
            api.find_files()
        else
            builtin.find_files()
        end
    end,
    {noremap = true, silent = true, desc = "Search files"})

-- Grep from files recursively in cwd
vim.keymap.set('n', '<leader>fg',
    function()
        if connections.is_connected() then
            api.live_grep()
        else
            builtin.live_grep()
        end
    end,
    {noremap = true, silent = true, desc = "Global grep"})

-- List harpooned buffers
vim.keymap.set('n', '<leader>fh', telescope.extensions.harpoon.marks, {noremap = true, silent = true, desc = "Show harpooned buffers"})

-- List todo items
vim.keymap.set('n', '<leader>ft', ":TodoTelescope<CR>", {noremap = true, silent = true, desc = "Todo-Comments"})
