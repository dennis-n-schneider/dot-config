local dap = require('dap')
require('dap-python').setup('~/.local/venv/nvim/bin/python')
require('dap-python').test_runner = 'pytest'
require('nvim-dap-virtual-text').setup()

local function get_arguments()
    local co = coroutine.running()
    if co then
        return coroutine.create(function()
            local args = {}
            vim.ui.input({ prompt = 'Enter command-line arguments: ' }, function(input)
                args = vim.split(input, " ")
            end)
            coroutine.resume(co, args)
        end)
    else
        local args = {}
        vim.ui.input({ prompt = 'Enter command-line arguments: ' }, function(input)
            args = vim.split(input, " ")
        end)
        return args
    end
end

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        console = "integratedTerminal",
        justMyCode = false,
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                -- Use .venv/ directory.
                return cwd .. '/.venv/bin/python'
            elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                -- If I should ever choose to use venv/ ...
                return cwd .. '/venv/bin/python'
            else
                -- Global pyenv-python version as fallback.
                return '/home/dns.local/share/pyenv/shims/python'
            end
        end,
        args = get_arguments,
    }
}

local exec_if_active = function(callable, alternative_str)
    local clojure = function()
        if dap.session() then
            callable()
        else
            return alternative_str
        end
        -- return M.debugger_active and callable() or alternative_str
    end
    return clojure
end

-- Keymaps when the debugger is not running.
vim.keymap.set('n', '<leader>dd', dap.toggle_breakpoint, {noremap = true, silent = true, desc = "Toggle breakpoint"})
vim.keymap.set('n', '<leader>da', dap.continue, {noremap = true, silent = true, desc = "Start/Stop debugger"})
--vim.keymap.set('n', '<leader>ds', dap.debug_selection(), {noremap = true, silent = true, desc = "Start/Stop debugger"})
--vim.keymap.set('n', '<leader>dt', dap.test_method(), {noremap = true, silent = true, desc = "Start/Stop debugger"})

local params = {noremap = true, silent = true, desc = "Toggle breakpoint", expr=true}
-- Keymaps when the debugger is running.
vim.keymap.set('n', 'n', exec_if_active(dap.continue, "n"), params)
vim.keymap.set('n', 'h', exec_if_active(dap.step_out, "h"), params)
vim.keymap.set('n', 'j', exec_if_active(dap.step_over, "j"), params)
-- vim.keymap.set('n', 'k', exec_if_active(dap.step_over, "k"), params)
vim.keymap.set('n', 'l', exec_if_active(dap.step_into, "l"), params)

vim.fn.sign_define('DapBreakpoint', {text="🔴", texthl="red", linehl="", numhl=""})
vim.fn.sign_define('DapStopped', {text="🞄", texthl="green", linehl="", numhl=""})
