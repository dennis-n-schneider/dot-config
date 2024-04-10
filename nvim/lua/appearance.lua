--[[
nvim autoenables showcmd, syntax
--]]

vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.signcolumn = "yes"
vim.o.fillchars = 'eob: '
vim.o.listchars = 'leadmultispace:    '
vim.o.list = true
vim.cmd([[colorscheme dracula]])
vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
-- vim.cmd([[hi WinSeparator guifg=#ffffff]])
