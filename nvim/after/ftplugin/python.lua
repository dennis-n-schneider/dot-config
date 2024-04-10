-- Show line after desired maximum text width
vim.opt_local.colorcolumn = '101'

-- Keybindings
vim.api.nvim_buf_set_keymap(0, 'i', '<M-i>', ' = ', { noremap = true })

vim.api.nvim_buf_set_keymap(0, 'n', '<c-q>', '<Cmd>call Black()<CR>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<c-w>', ':Isort<CR>', { noremap = true })


-- Section insert
-- EC.section_python = function()
--   -- Insert section template
--   vim.fn.append(vim.fn.line('.'), '# %% ')
-- 
--   -- Enable Insert mode in appropriate place
--   vim.fn.cursor(vim.fn.line('.') + 1, 5)
--   vim.cmd([[startinsert!]])
-- end
-- 
-- vim.api.nvim_buf_set_keymap(0, 'n', '<M-s>', '<Cmd>lua EC.section_python()<CR>', { noremap = true })
-- vim.api.nvim_buf_set_keymap(0, 'i', '<M-s>', '<Cmd>lua EC.section_python()<CR>', { noremap = true })
-- 
