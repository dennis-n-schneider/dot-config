function openZathuraIfConditionMet()
    vim.fn.system("cd " .. vim.api.nvim_buf_get_name(0))
    vim.fn.system("litemdview " .. vim.api.nvim_buf_get_name(0))
end

vim.api.nvim_set_keymap('n', '<leader>o', [[:lua openZathuraIfConditionMet()<CR>]], { noremap = true, silent = true })

-- By default, nvim conceals special characters. Do not do that. (Prettier Markdowns)
vim.opt_local.conceallevel = 2

